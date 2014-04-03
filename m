From: Alex Lemberg <Alex.Lemberg@sandisk.com>
Subject: RE: [RFC PATCH 1/1 ]mmc: Support-FFU-for-eMMC-v5.0
Date: Thu, 3 Apr 2014 14:18:07 +0000
Message-ID: <282CEDFCBC30114F83C499CB8F2ED53337EB7642@SACMBXIP02.sdcorp.global.sandisk.com>
References: <001901cf4ccf$3dc64920$b952db60$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [213.199.154.209] ([213.199.154.209]:53557 "EHLO
	am1outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752170AbaDCOT3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 3 Apr 2014 10:19:29 -0400
In-Reply-To: <001901cf4ccf$3dc64920$b952db60$@samsung.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seunguk Shin <seunguk.shin@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Avi Shchislowski <Avi.Shchislowski@sandisk.com>, "chris@printf.net" <chris@printf.net>, "cpgs@samsung.com" <cpgs@samsung.com>

Hi Seunguk,


> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Seunguk Shin
> Sent: Monday, March 31, 2014 1:52 PM
> To: linux-mmc@vger.kernel.org; Avi Shchislowski; chris@printf.net;
> cpgs@samsung.com
> Subject: Re: [RFC PATCH 1/1 ]mmc: Support-FFU-for-eMMC-v5.0
> 
> Some of Samsung eMMC does not show the argument for ffu in ext_csd.
> In case of this, eMMC shows 0x0 from ext_csd, Host has to modify the
> argument.
> 
> Add "#define CID_MANFID_SAMSUNG		0x15"
> 
> > +int mmc_ffu_download(struct mmc_card *card, struct mmc_command
> *cmd,
> > +       u8 *data, int buf_bytes)
> > +{
> > +       u8 ext_csd[CARD_BLOCK_SIZE];
> > +       int err;
> > +       int ret;
> > +
> > +       /* Read the EXT_CSD */
> > +       err = mmc_send_ext_csd(card, ext_csd);
> > +       if (err) {
> > +               pr_err("FFU: %s: error %d sending ext_csd\n",
> > +                       mmc_hostname(card->host), err);
> > +               goto exit;
> > +       }
> > +
> > +       /* Check if FFU is supported by card */
> > +       if (!FFU_SUPPORTED_MODE(ext_csd[EXT_CSD_SUPPORTED_MODE]))
> {
> > +               err = -EINVAL;
> > +               pr_err("FFU: %s: error %d FFU is not supported\n",
> > +                       mmc_hostname(card->host), err);
> > +               goto exit;
> > +       }
> > +
> > +       err = mmc_host_set_ffu(card, ext_csd[EXT_CSD_FW_CONFIG]);
> > +       if (err) {
> > +               pr_err("FFU: %s: error %d FFU is not supported\n",
> > +                       mmc_hostname(card->host), err);
> > +               err = -EINVAL;
> > +               goto exit;
> > +       }
> > +
> > +       /* set device to FFU mode */
> > +       err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> EXT_CSD_MODE_CONFIG,
> > +               MMC_FFU_MODE_SET, card->ext_csd.generic_cmd6_time);
> > +       if (err) {
> > +               pr_err("FFU: %s: error %d FFU is not supported\n",
> > +                       mmc_hostname(card->host), err);
> > +               goto exit_normal;
> > +       }
> > +
> > +       /* set CMD ARG */
> > +       cmd->arg = ext_csd[EXT_CSD_FFU_ARG] |
> > +               ext_csd[EXT_CSD_FFU_ARG + 1] << 8 |
> > +               ext_csd[EXT_CSD_FFU_ARG + 2] << 16 |
> > +               ext_csd[EXT_CSD_FFU_ARG + 3] << 24;
> > +
> 
> Add followings
> "
>        /* If arg is zero, should be set to a special value for samsung eMMC */
>        if ( card->cid.manfid == CID_MANFID_SAMSUNG && cmd->arg == 0x0 ) {
>                cmd->arg = 0xc7810000;
>        }
> "

This code is provides a generic FFU solution. 
I think it will be better to implement the Samsung-specific part as a QUIRK in MMC driver, and commit this as a separate patch.

> 
> > +       err = mmc_ffu_write(card, data, cmd->arg, buf_bytes);
> > +
> > +exit_normal:
> > +       /* host switch back to work in normal MMC Read/Write commands */
> > +       ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> > +               EXT_CSD_MODE_CONFIG, MMC_FFU_MODE_NORMAL,
> > +               card->ext_csd.generic_cmd6_time);
> > +       if (ret)
> > +               err = ret;
> > +
> > +exit:
> > +       return err;
> > +}
> > +EXPORT_SYMBOL(mmc_ffu_download);
> > +
> 
> 
> 
> eMMC 5.0 Spec. says if device does not support MODE_OPERATION_CODES,
> device doesn't need to use
> NUMBER_OF_FW_SECTORS_CORRECTLY_PROGRAMMED.
> So, it's better to move the code for checking this value to
> FFU_FEATURES(ext_csd[EXT_CSD_FFU_FEATURES]

OK, will be checked only in case of MODE_OPERATION_CODES is NOT supported.

> 
> > +int mmc_ffu_install(struct mmc_card *card) {
> > +       u8 ext_csd[CARD_BLOCK_SIZE];
> > +       int err;
> > +       u32 ffu_data_len;
> > +       u32 timeout;
> > +
> > +       err = mmc_send_ext_csd(card, ext_csd);
> > +       if (err) {
> > +               pr_err("FFU: %s: error %d sending ext_csd\n",
> > +                       mmc_hostname(card->host), err);
> > +               goto exit;
> > +       }
> > +
> > +       /* Check if FFU is supported */
> > +       if (!FFU_SUPPORTED_MODE(ext_csd[EXT_CSD_SUPPORTED_MODE])
> ||
> > +               FFU_CONFIG(ext_csd[EXT_CSD_FW_CONFIG])) {
> > +               err = -EINVAL;
> > +               pr_err("FFU: %s: error %d FFU is not supported\n",
> > +                       mmc_hostname(card->host), err);
> > +               goto exit;
> > +       }
> 
> Remove followings
> "
>        ffu_data_len = ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG]|
>                ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 1] << 8 |
>                ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 2] << 16 |
>                ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 3] << 24;
> 
>        if (!ffu_data_len) {
>                err = -EPERM;
>                return err;
>        }
> "
> 
> > +
> > +       /* check mode operation */
> > +       if (!FFU_FEATURES(ext_csd[EXT_CSD_FFU_FEATURES])) {
> > +               /* restart the eMMC */
> > +               err = mmc_ffu_restart(card);
> > +               if (err) {
> > +                       pr_err("FFU: %s: error %d FFU install:\n",
> > +                               mmc_hostname(card->host), err);
> > +               }
> > +       } else {
> 
> Add followings
> "
>                         ffu_data_len = ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG]|
>                                 ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 1] << 8
> |
>                                 ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 2] <<
> 16 |
>                                 ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 3] << 24;
> 
>                         if (!ffu_data_len) {
>                                 err = -EPERM;
>                                 return err;
>                         }
> "
> 
> > +                       /* set device to FFU mode */
> > +                       err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> > +                               EXT_CSD_MODE_CONFIG, 0x1,
> > +                               card->ext_csd.generic_cmd6_time);
> > +                       if (err) {
> > +                               pr_err("FFU: %s: error %d FFU is not
> supported\n",
> > +                                       mmc_hostname(card->host), err);
> > +                               goto exit;
> > +                       }
> 
> 
> 
> Checking ffu status in ext_csd should be done even if device does not support
> MODE_OPERATION_CODES So, it's better to move the code for checking this
> value to out of brace for FFU_FEATURES(ext_csd[EXT_CSD_FFU_FEATURES]
> 

You are right, we will move ffu status check to be done in both modes.

 
> > +                       /* set ext_csd to install mode */
> > +                       err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> > +                               EXT_CSD_MODE_OPERATION_CODES,
> > +                               MMC_FFU_INSTALL_SET, timeout);
> > +
> > +                       if (err) {
> > +                               pr_err("FFU: %s: error %d setting
> > + install
> mode\n",
> > +                                       mmc_hostname(card->host), err);
> > +                               goto exit;
> > +                       }
> > +
> 
> Remove followings
> "
>                        /* read ext_csd */
>                        err = mmc_send_ext_csd(card, ext_csd);
>                        if (err) {
>                                pr_err("FFU: %s: error %d sending ext_csd\n",
>                                        mmc_hostname(card->host), err);
>                                goto exit;
>                        }
>                        /* return status */
>                        err = ext_csd[EXT_CSD_FFU_STATUS];
>                        if (err) {
>                                pr_err("FFU: %s: error %d FFU install:\n",
>                                        mmc_hostname(card->host), err);
>                                err = -EINVAL;
>                                goto exit;
>                        }
> "
> 
> > +               }
> > +
> 
> Add followings
> "
>            /* read ext_csd */
>            err = mmc_send_ext_csd(card, ext_csd);
>            if (err) {
>                    pr_err("FFU: %s: error %d sending ext_csd\n",
>                               mmc_hostname(card->host), err);
>                    goto exit;
>            }
>            /* return status */
>            err = ext_csd[EXT_CSD_FFU_STATUS];
>            if (err) {
>                    pr_err("FFU: %s: error %d FFU install:\n",
>                               mmc_hostname(card->host), err);
>                    err = -EINVAL;
>                    goto exit;
>            }
> "
> 
> > +exit:
> > +       return err;
> > +}
> > +EXPORT_SYMBOL(mmc_ffu_install);
> > +
> 
> 
> 
> And some device's fw should be transferred with one command.
> They does not support multiple commands for fw transfer.
> For these devices, MMC_IOC_MAX_BYTES should be greater.
> 
> diff --git a/include/uapi/linux/mmc/ioctl.h b/include/uapi/linux/mmc/ioctl.h
> index 1f5e689..af9ea62 100644
> --- a/include/uapi/linux/mmc/ioctl.h
> +++ b/include/uapi/linux/mmc/ioctl.h
> @@ -53,5 +53,5 @@ struct mmc_ioc_cmd {
>   * is enforced per ioctl call.  For larger data transfers, use the normal
>   * block device operations.
>   */
> -#define MMC_IOC_MAX_BYTES  (512L * 256)
> +#define MMC_IOC_MAX_BYTES  (512L * 1024)
>  #endif /* LINUX_MMC_IOCTL_H */

We do not feel confident enough with changing the previously defined IOCTL limitation.
Our next patch (V2) should probably resolve FW size limitation - will use "udev" mechanism.

> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html


