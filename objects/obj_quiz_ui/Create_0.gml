// Quiz UI Variables
visible_ui = false;      // UI starts hidden
score_player = 0;
correct_answer = 0;
question_text = "";
current_ui_answers = [0,0,0,0];
feedback_timer = 0;
feedback_duration = 60; // half a second
selected_answer = -1;
showing_feedback = false;
randomise();


// Questions Array
questions = [

	/// 1. Expressions
	{
	    q_text: "Simplify: -{0}({1}-{2})+{3}",
	    ans: function(a)
	    {
	        return -a[0]*(a[1]-a[2]) + a[3];
	    },
	    range: [1,10]
	},

	{
	    q_text: "A recipe uses {0} cups of sugar. If you double it, how many cups do you need?",
	    ans: function(a)
	    {
	        return a[0]*2;
	    },
	    range: [1,6]
	},

	/// 2. Ratios
	{
	    q_text: "{0} books cost ${1}. How much does 1 book cost?",
	    ans: function(a)
	    {
	        return a[1] div a[0];
	    },
	    generator: function()
	    {
	        var books = irandom_range(2,6);
	        var price = irandom_range(2,10);
	        return [books, books*price];
	    }
	},

	{
	    q_text: "{0} books cost ${1}. How much do {2} books cost?",
	    ans: function(a)
	    {
	        return (a[1] div a[0]) * a[2];
	    },
	    generator: function()
	    {
	        var books = irandom_range(2,6);
	        var price = irandom_range(2,10);
	        var ask = irandom_range(2,8);
	        return [books, books*price, ask];
	    }
	},
	
	//Triangles
	{
	    q_text: "Right triangle with legs {0} and {1}. What is the hypotenuse?",
	    ans: function(a)
	    {
	        return sqrt(a[0]*a[0] + a[1]*a[1]);
	    },
	    generator: function()
	    {
	        var a, b, c;

	        repeat(100)
	        {
	            var m = irandom_range(2,5);
	            var n = irandom_range(1,m-1);

	            a = m*m - n*n;
	            b = 2*m*n;
	            c = m*m + n*n;

	            if c <= 20
	                break;
	        }

	        return [a,b];
	    }
	},

	{
	    q_text: "Right triangle hypotenuse {0} and one leg {1}. Find the other leg.",
	    ans: function(a)
	    {
	        return sqrt(a[0]*a[0] - a[1]*a[1]);
	    },
	    generator: function()
	    {
	        var leg1, leg2, hyp;

	        repeat(100)
	        {
	            var m = irandom_range(2,5);
	            var n = irandom_range(1,m-1);

	            leg1 = m*m - n*n;
	            leg2 = 2*m*n;
	            hyp  = m*m + n*n;

	            if hyp <= 20
	                break;
	        }

	        if irandom(1) == 0
	            return [hyp, leg1];
	        else
	            return [hyp, leg2];
	    }
	},

	/// 4. Angles
	{
	    q_text: "Two parallel lines are cut by a transversal. If one acute angle is {0}°, what is the corresponding angle?",
	    ans: function(a)
	    {
	        return a[0];
	    },
	    range: [20,70]
	},

	/// 5. Slope
	{
	    q_text: "Points A({0},{1}) and B({2},{3}). What is the slope?",
	    ans: function(a)
	    {
	        return (a[3]-a[1]) div (a[2]-a[0]);
	    },
	    generator: function()
	    {
	        var x1 = irandom_range(1,5);
	        var y1 = irandom_range(1,5);

	        var dx = irandom_range(1,5);
	        var dy = dx * irandom_range(1,4);

	        return [x1,y1,x1+dx,y1+dy];
	    }
	},

	{
	    q_text: "Line passes through ({0},{1}) and ({2},{3}). What is the y-intercept?",
	    ans: function(a)
	    {
	        var m = (a[3]-a[1]) div (a[2]-a[0]);
	        return a[1] - m*a[0];
	    },
	    generator: function()
	    {
	        var m = irandom_range(1,4);
	        var x1 = irandom_range(1,5);
	        var y1 = irandom_range(1,5);

	        var x2 = x1 + 1;
	        var y2 = y1 + m;

	        return [x1,y1,x2,y2];
	    }
	},

	/// 6. Mean
	{
	    q_text: "Data: {0},{1},{2},{3},{4},{5},{6}. What is the mean?",
	    ans: function(a)
	    {
	        return (a[0]+a[1]+a[2]+a[3]+a[4]+a[5]+a[6]) div 7;
	    },
	    generator: function()
	    {
	        var m = irandom_range(2,10);
	        return [m,m,m,m,m,m,m];
	    }
	},

	/// 7. Probability (integer form)
	{
	    q_text: "A spinner has 8 sections. {0} are red. How many are NOT red?",
	    ans: function(a)
	    {
	        return 8 - a[0];
	    },
	    range: [1,7]
	},

	/// 8. LCM
	{
	    q_text: "Lights flash every {0} seconds and {1} seconds. When do they flash together again?",
	    ans: function(a)
	    {
	        return lcm(a[0],a[1]);
	    },
	    range: [2,10]
	},

	/// 9. Outfit combinations
	{
	    q_text: "You have {0} shirts and {1} pants. How many outfits?",
	    ans: function(a)
	    {
	        return a[0]*a[1];
	    },
	    range: [2,10]
	},

	/// 10. Circle area (π ≈ 3)
	{
	    q_text: "Circle radius {0}. Using π≈3, what is the area?",
	    ans: function(a)
	    {
	        return 3*a[0]*a[0];
	    },
	    range: [2,10]
	},


	/// 11. Rectangle geometry
	{
	    q_text: "Rectangle width {0} and height {1}. What is the perimeter?",
	    ans: function(a)
	    {
	        return 2*(a[0]+a[1]);
	    },
	    range: [2,12]
	},

	{
	    q_text: "Rectangle width {0} and height {1}. What is the area?",
	    ans: function(a)
	    {
	        return a[0]*a[1];
	    },
	    range: [2,12]
	},

	/// 12. Distance
	{
	    q_text: "Distance between ({0},{1}) and ({2},{3})?",
	    ans: function(a)
	    {
	        var dx = a[2]-a[0];
	        var dy = a[3]-a[1];
	        return sqrt(dx*dx + dy*dy);
	    },
	    generator: function()
	    {
	        var triples = [
	            [0,0,3,4],
	            [0,0,5,12],
	            [1,1,4,5],
	            [2,3,10,9]
	        ];
	        return triples[irandom(array_length(triples)-1)];
	    }
	},

	/// 13. Walking displacement
	{
	    q_text: "Walk {0} north then {1} south. How far north from start?",
	    ans: function(a)
	    {
	        return abs(a[0]-a[1]);
	    },
	    range: [1,10]
	}

];

function show_ui() {
    visible_ui = true;          // make UI appear
    generate_random_question();  // generate new random question
}

function generate_random_question()
{
	// Return null if no questions
    if array_length(questions) == 0 return;
	
	// Choose template
    var template = questions[irandom(array_length(questions)-1)];

    var max_index = -1;
	
	// Get numbers
    for (var i = 1; i <= string_length(template.q_text); i++)
    {
        if string_char_at(template.q_text, i) == "{"
        {
            var j = i + 1;
            var num_str = "";

            while (string_char_at(template.q_text, j) != "}")
            {
                num_str += string_char_at(template.q_text, j);
                j++;
            }

            var idx = real(num_str);
            if idx > max_index
                max_index = idx;
        }
    }

    var needed = max_index + 1;

    var nums;
	
    if variable_struct_exists(template, "generator")
    {
        nums = template.generator();
    }
    else
    {
        nums = [];

        for (var i = 0; i < needed; i++)
        {
            array_push(nums, irandom_range(template.range[0], template.range[1]));
        }
    }

    question_text = template.q_text;
	// Solve for correct
    for (var i = 0; i < array_length(nums); i++)
    {
        question_text = string_replace(
            question_text,
            "{" + string(i) + "}",
            string(nums[i])
        );
    }

    correct_answer = template.ans(nums);
	
	// Generate incorrect answers
    var wrong1 = correct_answer + irandom_range(1,5);
    var wrong2 = correct_answer - irandom_range(1,5);
    var wrong3 = correct_answer + irandom_range(6,10);

    var options = [correct_answer, wrong1, wrong2, wrong3];

    // shuffle
    for (var i = 3; i > 0; i--)
    {
        var j = irandom(i);
        var tmp = options[i];
        options[i] = options[j];
        options[j] = tmp;
    }

    current_ui_answers = options;
}

function process_answer(index) {
    if (showing_feedback) return; // prevent spam clicks

    selected_answer = index;
    var chosen = current_ui_answers[index];

    showing_feedback = true;
    feedback_timer = feedback_duration;

    if (chosen == correct_answer) {
        score_player += 10;
		audio_play_sound(Sound_correct,5,false);
        show_debug_message("Correct!");
    } else {
		audio_play_sound(Sound_incorrect,5,false);
        show_debug_message("Wrong!");
    }
}