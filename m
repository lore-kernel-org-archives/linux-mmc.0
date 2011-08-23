From: Ben Pfaff <blp@cs.stanford.edu>
Subject: Re: [PATCH 2/2] mmc: fix integer assignments to pointer
Date: Tue, 23 Aug 2011 13:43:57 -0700
Message-ID: <87wre3luya.fsf@blp.benpfaff.org>
References: <1314114363-6767-1-git-send-email-svenkatr@ti.com>
	<1314114363-6767-3-git-send-email-svenkatr@ti.com>
	<m27h643x8k.fsf@bob.laptop.org> <20110823172851.GB1784@leaf>
	<874o18m2cn.fsf@blp.benpfaff.org> <20110823181359.GB3418@leaf>
Reply-To: Ben Pfaff <blp@cs.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
In-Reply-To: <20110823181359.GB3418@leaf> (Josh Triplett's message of "Tue, 23
	Aug 2011 11:13:59 -0700")
Sender: linux-sparse-owner@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Chris Ball <cjb@laptop.org>, Venkatraman S <svenkatr@ti.com>, linux-mmc@vger.kernel.org, linux-sparse@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Josh Triplett <josh@joshtriplett.org> writes:

> On Tue, Aug 23, 2011 at 11:04:08AM -0700, Ben Pfaff wrote:
>> Josh Triplett <josh@joshtriplett.org> writes:
>> 
>> > On Tue, Aug 23, 2011 at 12:31:55PM -0400, Chris Ball wrote:
>> >> On Tue, Aug 23 2011, Venkatraman S wrote:
>> >> > -	struct mmc_request mrq = {0};
>> >> > +	struct mmc_request mrq = {NULL};
>> >> 
>> >> The sparse warning is mistaken.  Or I'm mistaken.  But I suspect it's
>> >> the sparse warning.
>> >
>> > Notice that it says "the remainder of the aggregate".  The first field
>> > still gets initialized with the 0 you supplied, and the first field of
>> > struct mmc_request has a pointer type.
>> 
>> That's an understandable position, but I think it would also be
>> reasonable for sparse to special case using {0} as an
>> initializer.  {0} is a valid initializer for every type and so
>> it's sometimes used as an initializer for a local variable to get
>> the same effect that one would have for a static variable without
>> specifying an initializer.
>
> {} produces the same effect, as far as I know.

{} is not a valid initializer for every type in the same way as
{0}, e.g.:

    blp@hardrock:~/db$ cat > tmp.c
    int x = {};
    int y = {0};
    blp@hardrock:~/db$ gcc tmp.c
    tmp.c:1:1: error: empty scalar initializer
    tmp.c:1:1: error: (near initialization for 'x')

-- 
Ben Pfaff 
http://benpfaff.org
