From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH/RFC 1/3] mmc: tmio: Add tuning support
Date: Fri, 13 May 2016 11:36:02 +0900
Message-ID: <20160513023601.GF24529@verge.net.au>
References: <1462859524-28522-1-git-send-email-horms+renesas@verge.net.au>
 <1462859524-28522-2-git-send-email-horms+renesas@verge.net.au>
 <SG2PR06MB091980ABDB9B697B47A1AE98D8730@SG2PR06MB0919.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <SG2PR06MB091980ABDB9B697B47A1AE98D8730@SG2PR06MB0919.apcprd06.prod.outlook.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Ben Hutchings <ben.hutchings@codethink.co.uk>, Ian Molton <ian@mnementh.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, May 12, 2016 at 06:12:44AM +0000, Yoshihiro Shimoda wrote:
> Hi Simon-san,
> 
> > From: Behalf Of Simon Horman
> > Sent: Tuesday, May 10, 2016 2:52 PM
> > 
> > From: Ai Kyuse <ai.kyuse.uw@renesas.com>
> > 
> > Add tuning support for use with SDR104 mode
> > 
> > Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> I have some minor comments :)
> 
> < snip >
> > @@ -753,6 +785,157 @@ static int tmio_mmc_start_data(struct tmio_mmc_host *host,
> >  	return 0;
> >  }
> > 
> > +#define TMIO_MMC_MAX_TUNING_LOOP 40
> > +
> > +static int tmio_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
> > +{
> > +	struct tmio_mmc_host *host = mmc_priv(mmc);
> > +	struct mmc_ios *ios = &mmc->ios;
> > +
> > +	unsigned long timeout, val;
> > +	unsigned long *tap;
> > +	int tuning_loop_counter = TMIO_MMC_MAX_TUNING_LOOP;
> < snip >
> > +	/*
> > +	 * Issue CMD19 repeatedly till Execute Tuning is set to 0 or the number
> > +	 * of loops reaches 40 times or a timeout of 150ms occurs.
> > +	 */
> > +	timeout = 150;
> 
> The tuning_loop_counter is 40 and timeout is 150.
> However,
> 
> > +	do {
> > +		if (host->prepare_tuning)
> > +			host->prepare_tuning(host, val % num);
> > +
> > +		if (!tuning_loop_counter && !timeout)
> > +			break;
> 
> < snip >
> 
> > +		tuning_loop_counter--;
> > +		timeout--;
> > +		mdelay(1);
> > +	} while ((val < (num * 2)) && (tuning_loop_counter || timeout));
> 
> They will be decreased by 1. So, I think we don't need either variable.

Thanks for bringing this to my attention.

As Wolfram pointed out in another sub-thread it looks like this code
is based on sdhci.c. And I believe that the version in that file has
the issue you raise addressed by:

7ce45e950624 ("mmc: sdhci: SD tuning is broken for some controllers").

I'll update this patch accordingly.

> 
> > +	 * The Host Driver has exhausted the maximum number of loops allowed,
> > +	 * so use fixed sampling frequency.
> > +	 */
> > +	if (tuning_loop_counter || timeout) {
> > +		if (host->select_tuning) {
> > +			ret = host->select_tuning(host, tap);
> > +			if (ret < 0)
> > +				goto out;
> > +		}
> > +		host->done_tuning = true;
> > +	} else {
> > +		dev_warn(&host->pdev->dev, ": Tuning procedure failed\n");
> 
> The first 2 charactors ": " is strange to me.

Yes, thanks for noticing that. I plan to drop ": ".

> > +		ret = -EIO;
> > +		goto out;
> > +	}
> > +
> > +out:
> > +	kfree(data_buf);
> > +err_data:
> > +	kfree(tap);
> > +err_tap:
> > +	if (ret < 0 && host->hw_reset)
> > +		host->hw_reset(host);
> 
> We can use tmio_mmc_hw_reset() of this patch.
> Then, we can remove the condition of "host->hw_reset".

Thanks, will do.

[...]
