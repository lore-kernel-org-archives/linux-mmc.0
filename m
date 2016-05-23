From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH/RFC v2 1/3] mmc: tmio: Add tuning support
Date: Mon, 23 May 2016 10:33:08 +0900
Message-ID: <20160523013308.GF25562@verge.net.au>
References: <1463727743-7567-1-git-send-email-horms+renesas@verge.net.au>
 <1463727743-7567-2-git-send-email-horms+renesas@verge.net.au>
 <87fut9siq8.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87fut9siq8.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ai Kyuse <ai.kyuse.uw@renesas.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, May 23, 2016 at 12:53:59AM +0000, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> Thank you for your patch.
> Picky comment from me :)

Thanks for noticing these things and sorry for not having
done so myself.

> > From: Ai Kyuse <ai.kyuse.uw@renesas.com>
> > 
> > Add tuning support for use with SDR104 mode
> > 
> > Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> (snip)
> > @@ -160,6 +161,11 @@ struct tmio_mmc_host {
> >  			      unsigned int direction, int blk_size);
> >  	int (*start_signal_voltage_switch)(struct mmc_host *mmc,
> >  					   struct mmc_ios *ios);
> > +	unsigned int (*init_tuning)(struct tmio_mmc_host *host);
> > +	int (*prepare_tuning)(struct tmio_mmc_host *host, unsigned long tap);
> > +	int (*select_tuning)(struct tmio_mmc_host *host, bool *tap);
> > +	bool (*retuning)(struct tmio_mmc_host *host);
> > +	void (*hw_reset)(struct tmio_mmc_host *host);
> >  };
> 
> There is no (*retuning) code ?

Thanks, I think returning should simply be removed.

> > +static int tmio_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
> > +{
> > +	struct tmio_mmc_host *host = mmc_priv(mmc);
> > +	unsigned int num = 0;
> > +	int i, ret = 0;
> > +	bool *tap;
> > +
> > +	if (host->init_tuning)
> > +		num = host->init_tuning(host);
> > +	if (!num) {
> > +		/* Tuning is not supported */
> > +		ret = 0;
> > +		goto out;
> > +	}
> > +
> > +	tap = kmalloc(num * 2, GFP_KERNEL);
> > +	if (tap == NULL) {
> > +		ret = -ENOMEM;
> > +		goto out;
> > +	}
> 
> 	if (!tap) {
> 		...
> 	}

ok

> > +	/*
> > +	 * Issue CMD19 twice for each tap
> > +	 */
> > +	for (i = 0; i < 2 * num; i++) {
> > +		int err;
> > +
> > +		if (host->prepare_tuning)
> > +			host->prepare_tuning(host, i);
> 
> you want to check return value here ?
> 	int (*prepare_tuning)(xxx);

The implementation of prepare_tuning doesn't seem to ever return an error.
Perhaps it would be best to just change the type to:

	void (*prepare_tuning)(xxx);

> > +		err = mmc_send_tuning(host->mmc, opcode, NULL);
> > +		if (err && err != -EILSEQ) {
> > +			ret = err;
> > +			goto err_free;
> > +		}
> > +		tap[i] = (err == 0);
> > +
> > +		mdelay(1);
> > +	}
> > +
> > +	if (host->select_tuning)
> > +		ret = host->select_tuning(host, tap);
> 
> Here, "tap" was alloc:ed array, but there is no array_size parameter.
> A littile bit strange for me..., but I'm not sure

Right. I think its safe. But its not very clean.
I will add a size parameter.
