From: Jackey Shen <jackey.shen@amd.com>
Subject: Re: [PATCH] mmc-utils: add the revision for eMMC5.0
Date: Wed, 4 Dec 2013 16:02:38 +0800
Message-ID: <20131204080238.GA2764@ubuntu.amd.com>
References: <529E775B.5000308@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:33296 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753394Ab3LDIAg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Dec 2013 03:00:36 -0500
Content-Disposition: inline
In-Reply-To: <529E775B.5000308@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 'Chris Ball' <cjb@laptop.org>

On Wed, Dec 04, 2013 at 09:29:15AM +0900, Jaehoon Chung wrote:
> To know whether eMMC card is version5.0 or not, add the check point.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Reviewed-by: Jackey Shen <Jackey.Shen@amd.com>

> ---
>  mmc_cmds.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index b8afa74..5edf42b 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -722,6 +722,9 @@ int do_read_extcsd(int nargs, char **argv)
>  	ext_csd_rev = ext_csd[192];
>  
>  	switch (ext_csd_rev) {
> +	case 7:
> +		str = "5.0";
> +		break;
>  	case 6:
>  		str = "4.5";
>  		break;
> -- 
> 1.7.9.5
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

