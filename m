From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] Add eMMC 5.0 support
Date: Thu, 20 Feb 2014 11:12:49 +0900
Message-ID: <530564A1.50708@samsung.com>
References: <1392817677-4755-1-git-send-email-yix.x.zhang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:41544 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbaBTCMh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Feb 2014 21:12:37 -0500
In-reply-to: <1392817677-4755-1-git-send-email-yix.x.zhang@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhang Yi <yix.x.zhang@gmail.com>, cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

You can refer to this.

http://comments.gmane.org/gmane.linux.kernel.mmc/23838

Best Regards,
Jaehoon Chung

On 02/19/2014 10:47 PM, Zhang Yi wrote:
> Current code will exist when read eMMC 5.0, add support for it
> 
> Signed-off-by: Zhang Yi <yix.x.zhang@gmail.com>
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
> 

