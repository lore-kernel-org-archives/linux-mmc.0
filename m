From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 2/5] smd: Make packet size a constant
Date: Wed, 23 Nov 2016 22:14:50 -0800
Message-ID: <20161124061450.GV28340@tuxbot>
References: <1479863388-23678-1-git-send-email-jeremymc@redhat.com>
 <1479863388-23678-3-git-send-email-jeremymc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1479863388-23678-3-git-send-email-jeremymc@redhat.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Jeremy McNicoll <jeremymc@redhat.com>
Cc: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, andy.gross@linaro.org, sboyd@codeaurora.org, robh@kernel.org, arnd@arndb.de, riteshh@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

On Tue 22 Nov 17:09 PST 2016, Jeremy McNicoll wrote:

> Use a macro to define the maximum size of a RPM message.
> 

No thanks.

> Signed-off-by: Jeremy McNicoll <jeremymc@redhat.com>
> ---
>  drivers/soc/qcom/smd-rpm.c   | 2 +-
>  include/linux/soc/qcom/smd.h | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
> index 6609d7e..b5a2836 100644
> --- a/drivers/soc/qcom/smd-rpm.c
> +++ b/drivers/soc/qcom/smd-rpm.c
> @@ -114,7 +114,7 @@ int qcom_rpm_smd_write(struct qcom_smd_rpm *rpm,
>  	size_t size = sizeof(*pkt) + count;
>  
>  	/* SMD packets to the RPM may not exceed 256 bytes */
> -	if (WARN_ON(size >= 256))
> +	if (WARN_ON(size >= SMD_RPM_MAX_SIZE))
>  		return -EINVAL;

The only thing you do is to change "oh, the max packet size is 256
bytes" to "hmm, i wonder what SMD_RPM_MAX_SIZE is and if the comment is
still valid".

>  
>  	pkt = kmalloc(size, GFP_KERNEL);
> diff --git a/include/linux/soc/qcom/smd.h b/include/linux/soc/qcom/smd.h
> index f148e0f..8039015 100644
> --- a/include/linux/soc/qcom/smd.h
> +++ b/include/linux/soc/qcom/smd.h
> @@ -4,6 +4,13 @@
>  #include <linux/device.h>
>  #include <linux/mod_devicetable.h>
>  
> +
> +/*
> + * SMD packets to the RPM may not exceed 256 bytes
> + */
> +#define SMD_RPM_MAX_SIZE 256
> +

And this has nothing to do with SMD, it's a limitation of RPM.

Regards,
Bjorn
