From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: host: use resource_size()
Date: Fri, 22 Mar 2013 12:53:36 -0400
Message-ID: <87r4j7ml4f.fsf@octavius.laptop.org>
References: <1363112486-2543-1-git-send-email-silviupopescu1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363112486-2543-1-git-send-email-silviupopescu1990@gmail.com>
	(Silviu-Mihai Popescu's message of "Tue, 12 Mar 2013 20:21:26 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
Cc: linux-mmc@vger.kernel.org, yunhong.jiang@intel.com, sheng@linux.intel.com, mikechan@google.com, xiaohui.xin@intel.com, jun.nakajima@intel.com, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, Mar 12 2013, Silviu-Mihai Popescu wrote:
> Use resource_size() instead of explicit calculation. This was found via
> make coccicheck.
>
> Signed-off-by: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
> ---
>  drivers/mmc/host/android-goldfish.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/android-goldfish.c b/drivers/mmc/host/android-goldfish.c
> index ef3aef0..7780c14 100644
> --- a/drivers/mmc/host/android-goldfish.c
> +++ b/drivers/mmc/host/android-goldfish.c
> @@ -476,7 +476,7 @@ static int goldfish_mmc_probe(struct platform_device *pdev)
>  	host->mmc = mmc;
>  
>  	pr_err("mmc: Mapping %lX to %lX\n", (long)res->start, (long)res->end);
> -	host->reg_base = ioremap(res->start, res->end - res->start + 1);
> +	host->reg_base = ioremap(res->start, resource_size(res));
>  	if (host->reg_base == NULL) {
>  		ret = -ENOMEM;
>  		goto ioremap_failed;

Thanks, pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
