From: blp@cs.stanford.edu (Ben Pfaff)
Subject: Re: [PATCH 2/2] mmc: fix integer assignments to pointer
Date: Tue, 23 Aug 2011 11:04:08 -0700
Message-ID: <874o18m2cn.fsf@blp.benpfaff.org>
References: <1314114363-6767-1-git-send-email-svenkatr@ti.com>
	<1314114363-6767-3-git-send-email-svenkatr@ti.com>
	<m27h643x8k.fsf@bob.laptop.org> <20110823172851.GB1784@leaf>
Reply-To: blp@cs.stanford.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Reply-to: blp@cs.stanford.edu
In-Reply-To: <20110823172851.GB1784@leaf> (Josh Triplett's message of "Tue, 23
	Aug 2011 10:28:51 -0700")
Sender: linux-sparse-owner@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Chris Ball <cjb@laptop.org>, Venkatraman S <svenkatr@ti.com>, linux-mmc@vger.kernel.org, linux-sparse@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Josh Triplett <josh@joshtriplett.org> writes:

> On Tue, Aug 23, 2011 at 12:31:55PM -0400, Chris Ball wrote:
>> On Tue, Aug 23 2011, Venkatraman S wrote:
>> > -	struct mmc_request mrq = {0};
>> > +	struct mmc_request mrq = {NULL};
>> 
>> The sparse warning is mistaken.  Or I'm mistaken.  But I suspect it's
>> the sparse warning.
>
> Notice that it says "the remainder of the aggregate".  The first field
> still gets initialized with the 0 you supplied, and the first field of
> struct mmc_request has a pointer type.

That's an understandable position, but I think it would also be
reasonable for sparse to special case using {0} as an
initializer.  {0} is a valid initializer for every type and so
it's sometimes used as an initializer for a local variable to get
the same effect that one would have for a static variable without
specifying an initializer.
-- 
Ben Pfaff 
http://benpfaff.org
