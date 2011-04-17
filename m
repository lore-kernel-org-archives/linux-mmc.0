From: Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v2 03/12] mmc: mmc_test: add test for none blocking
	transfers
Date: Sun, 17 Apr 2011 23:46:23 +0800
Message-ID: <20110417154622.GC17935@S2100-06.ap.freescale.net>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
	<1302116833-24540-4-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1302116833-24540-4-git-send-email-per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Apr 06, 2011 at 09:07:04PM +0200, Per Forlin wrote:
[...]
> +static int mmc_test_rw_multiple(struct mmc_test_card *test,
> +				struct mmc_test_multiple_rw *tdata,
> +				unsigned int reqsize, unsigned int size)
> +{
> +	unsigned int dev_addr;
> +	struct mmc_test_area *t = &test->area;
> +	int ret = 0;
> +	int max_reqsize = max(t->mem->size_min_cmn *
> +			      min(t->max_segs, t->mem->cnt), t->max_tfr);
> +
The 'max(..., t->max_tfr)' probably should be 'min(..., t->max_tfr)'.
Otherwise, I see mmc_test failure on my mxs-mmc setup.

mmc0: Test case 37. Write performance with blocking req 4k to 4MB...
mmc0: Transfer of 64 x 2048 sectors (64 x 1024 KiB) took 5.412563314 seconds (12
398 kB/s, 12108 KiB/s, 11.82 IOPS)
mmc0: Failed to map sg list
[mmc_test_rw_multiple] error
mmc0: Result: ERROR (-22)

-- 
Regards,
Shawn
