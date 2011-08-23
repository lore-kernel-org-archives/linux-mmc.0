From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 2/2] mmc: fix integer assignments to pointer
Date: Tue, 23 Aug 2011 18:56:20 +0200
Message-ID: <20110823165620.GA9132@merkur.ravnborg.org>
References: <1314114363-6767-1-git-send-email-svenkatr@ti.com> <1314114363-6767-3-git-send-email-svenkatr@ti.com> <m27h643x8k.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.snhosting.dk ([87.238.248.203]:56064 "EHLO
	smtp.domainteam.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259Ab1HWQ4W (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Aug 2011 12:56:22 -0400
Content-Disposition: inline
In-Reply-To: <m27h643x8k.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Venkatraman S <svenkatr@ti.com>, linux-mmc@vger.kernel.org, linux-sparse@vger.kernel.org

On Tue, Aug 23, 2011 at 12:31:55PM -0400, Chris Ball wrote:
> Hi,
> 
> [Adding linux-sparse@ to CC]
> 
> On Tue, Aug 23 2011, Venkatraman S wrote:
> > Fix the sparse warning output
> > "warning: Using plain integer as NULL pointer"
> >
> > Signed-off-by: Venkatraman S <svenkatr@ti.com>
> > ---
> >  drivers/mmc/card/block.c    |    4 ++--
> >  drivers/mmc/core/core.c     |    2 +-
> >  drivers/mmc/core/mmc_ops.c  |    4 ++--
> >  drivers/mmc/core/sdio_ops.c |    2 +-
> >  4 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> > index 1ff5486..e702c61 100644
> > --- a/drivers/mmc/card/block.c
> > +++ b/drivers/mmc/card/block.c
> > @@ -291,7 +291,7 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
> >  	struct mmc_card *card;
> >  	struct mmc_command cmd = {0};
> >  	struct mmc_data data = {0};
> > -	struct mmc_request mrq = {0};
> > +	struct mmc_request mrq = {NULL};
> >  	struct scatterlist sg;
> >  	int err;
> > [...]
> 
> The sparse warning is mistaken.  Or I'm mistaken.  But I suspect it's
> the sparse warning.
> 
> The {0} syntax is covered by:
> 
>    [6.7.8.21] If there are fewer initializers in a brace-enclosed list
>    than there are elements or members of an aggregate, or fewer
>    characters in a string literal used to initialize an array of known
>    size than there are elements in the array, the remainder of the
>    aggregate shall be initialized implicitly the same as objects that
>    have static storage duration.
> 
> So we're not assigning 0 to a pointer, or whatever sparse thinks we're
> doing -- we're initializing every member of the struct with 0, which is
> a good and safe way to initialize it.
> 
> Sparse folks, any comment?

The struct looks like this:
struct mmc_request {
        struct mmc_command      *sbc;           /* SET_BLOCK_COUNT for multiblock */
        struct mmc_command      *cmd;
        struct mmc_data         *data;
        struct mmc_command      *stop;

        struct completion       completion;
        void                    (*done)(struct mmc_request *);/* completion function */
};


So you assing '0' to sbc - which is a pointer.
So sparse warning is correct.

	Sam
