From: Grant Grundler <grundler@chromium.org>
Subject: Re: [RFC PATCH 1/1 ]mmc: Support-FFU-for-eMMC-v5.0
Date: Tue, 1 Apr 2014 13:30:20 -0700
Message-ID: <CANEJEGu8btGqp=NqV+JjFBWKxSh6_=DcsbH4aoL9tGgK2xcUFA@mail.gmail.com>
References: <001901cf4ccf$3dc64920$b952db60$@samsung.com>
	<533A3DD7.80403@samsung.com>
	<CANEJEGt=5EegY80F3EvsG70poUwVFRjeZT-hUJD8LdULAz=S_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:46258 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbaDAUaV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Apr 2014 16:30:21 -0400
Received: by mail-oa0-f49.google.com with SMTP id o6so1357188oag.8
        for <linux-mmc@vger.kernel.org>; Tue, 01 Apr 2014 13:30:21 -0700 (PDT)
In-Reply-To: <CANEJEGt=5EegY80F3EvsG70poUwVFRjeZT-hUJD8LdULAz=S_w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Seunguk Shin <seunguk.shin@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Avi Shchislowski <Avi.Shchislowski@sandisk.com>, Chris Ball <chris@printf.net>, CPGS <cpgs@samsung.com>, Puthikorn Voravootivat <puthik@chromium.org>, Gwendal Grignou <gwendal@chromium.org>

argh...reposting my response as text only since linux-mmc doesn't like
html mail. :(

On Tue, Apr 1, 2014 at 1:26 PM, Grant Grundler <grundler@chromium.org> wrote:
>
>
>
> On Mon, Mar 31, 2014 at 9:17 PM, Jaehoon Chung <jh80.chung@samsung.com>
> wrote:
>>
>> Hi, Seunguk.
>>
>> On 03/31/2014 07:51 PM, Seunguk Shin wrote:
>> > Some of Samsung eMMC does not show the argument for ffu in ext_csd.
>> > In case of this, eMMC shows 0x0 from ext_csd, Host has to modify the
>> > argument.
>> >
>> > Add "#define CID_MANFID_SAMSUNG               0x15"
>> If you need to add the Samsung eMMC specific code,
>> it would be better you would send the Samsung eMMC specific patch.
>> (based-on this patch.)
>
>
> I believe Seunguk Shin provided the information so someone else could add
> this code. I could be that person if no one from Samsung has have time for
> this.  I'm very grateful to Seungguk for posting these details.
>
> I hope we can see the same details for Samsung eMMC 4.5 also (but please use
> a different email Subject line so we aren't confused.)
>
>> This patch isn't patch for samsung eMMC.
>> I didn't see this patch fully, but i think this patch is general code.
>
>
> AFAICT, the MANFID_SAMSUNG is only a "quirk" for Samsung devices which
> specify the EXT_CSD_FFU_ARG as 0.
>
> The original patch from SanDisk is general code and most of Seunguk's
> comments are general too. SanDisk (ie Avi) should please ACK they've seen
> those comments since I believe Seunguk is correct.
>
> And Avi, please let us know if/when you plan on posting a V2. Or at least
> not be offended if I get impatient and hijack this patch series. :)
>
> cheers,
> grant
>
>> Best Regards,
>> Jaehoon Chung
>>
>> >
>> >> +int mmc_ffu_download(struct mmc_card *card, struct mmc_command *cmd,
>> >> +       u8 *data, int buf_bytes)
>> >> +{
>> >> +       u8 ext_csd[CARD_BLOCK_SIZE];
>> >> +       int err;
>> >> +       int ret;
>> >> +
>> >> +       /* Read the EXT_CSD */
>> >> +       err = mmc_send_ext_csd(card, ext_csd);
>> >> +       if (err) {
>> >> +               pr_err("FFU: %s: error %d sending ext_csd\n",
>> >> +                       mmc_hostname(card->host), err);
>> >> +               goto exit;
>> >> +       }
>> >> +
>> >> +       /* Check if FFU is supported by card */
>> >> +       if (!FFU_SUPPORTED_MODE(ext_csd[EXT_CSD_SUPPORTED_MODE])) {
>> >> +               err = -EINVAL;
>> >> +               pr_err("FFU: %s: error %d FFU is not supported\n",
>> >> +                       mmc_hostname(card->host), err);
>> >> +               goto exit;
>> >> +       }
>> >> +
>> >> +       err = mmc_host_set_ffu(card, ext_csd[EXT_CSD_FW_CONFIG]);
>> >> +       if (err) {
>> >> +               pr_err("FFU: %s: error %d FFU is not supported\n",
>> >> +                       mmc_hostname(card->host), err);
>> >> +               err = -EINVAL;
>> >> +               goto exit;
>> >> +       }
>> >> +
>> >> +       /* set device to FFU mode */
>> >> +       err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> > EXT_CSD_MODE_CONFIG,
>> >> +               MMC_FFU_MODE_SET, card->ext_csd.generic_cmd6_time);
>> >> +       if (err) {
>> >> +               pr_err("FFU: %s: error %d FFU is not supported\n",
>> >> +                       mmc_hostname(card->host), err);
>> >> +               goto exit_normal;
>> >> +       }
>> >> +
>> >> +       /* set CMD ARG */
>> >> +       cmd->arg = ext_csd[EXT_CSD_FFU_ARG] |
>> >> +               ext_csd[EXT_CSD_FFU_ARG + 1] << 8 |
>> >> +               ext_csd[EXT_CSD_FFU_ARG + 2] << 16 |
>> >> +               ext_csd[EXT_CSD_FFU_ARG + 3] << 24;
>> >> +
>> >
>> > Add followings
>> > "
>> >        /* If arg is zero, should be set to a special value for samsung
>> > eMMC
>> > */
>> >        if ( card->cid.manfid == CID_MANFID_SAMSUNG && cmd->arg == 0x0 )
>> > {
>> >                cmd->arg = 0xc7810000;
>> >        }
>> > "
>> >
>> >> +       err = mmc_ffu_write(card, data, cmd->arg, buf_bytes);
>> >> +
>> >> +exit_normal:
>> >> +       /* host switch back to work in normal MMC Read/Write commands
>> >> */
>> >> +       ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> >> +               EXT_CSD_MODE_CONFIG, MMC_FFU_MODE_NORMAL,
>> >> +               card->ext_csd.generic_cmd6_time);
>> >> +       if (ret)
>> >> +               err = ret;
>> >> +
>> >> +exit:
>> >> +       return err;
>> >> +}
>> >> +EXPORT_SYMBOL(mmc_ffu_download);
>> >> +
>> >
>> >
>> >
>> > eMMC 5.0 Spec. says if device does not support MODE_OPERATION_CODES,
>> > device
>> > doesn't need to use NUMBER_OF_FW_SECTORS_CORRECTLY_PROGRAMMED.
>> > So, it's better to move the code for checking this value to
>> > FFU_FEATURES(ext_csd[EXT_CSD_FFU_FEATURES]
>> >
>> >> +int mmc_ffu_install(struct mmc_card *card) {
>> >> +       u8 ext_csd[CARD_BLOCK_SIZE];
>> >> +       int err;
>> >> +       u32 ffu_data_len;
>> >> +       u32 timeout;
>> >> +
>> >> +       err = mmc_send_ext_csd(card, ext_csd);
>> >> +       if (err) {
>> >> +               pr_err("FFU: %s: error %d sending ext_csd\n",
>> >> +                       mmc_hostname(card->host), err);
>> >> +               goto exit;
>> >> +       }
>> >> +
>> >> +       /* Check if FFU is supported */
>> >> +       if (!FFU_SUPPORTED_MODE(ext_csd[EXT_CSD_SUPPORTED_MODE]) ||
>> >> +               FFU_CONFIG(ext_csd[EXT_CSD_FW_CONFIG])) {
>> >> +               err = -EINVAL;
>> >> +               pr_err("FFU: %s: error %d FFU is not supported\n",
>> >> +                       mmc_hostname(card->host), err);
>> >> +               goto exit;
>> >> +       }
>> >
>> > Remove followings
>> > "
>> >        ffu_data_len = ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG]|
>> >                ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 1] << 8 |
>> >                ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 2] << 16 |
>> >                ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 3] << 24;
>> >
>> >        if (!ffu_data_len) {
>> >                err = -EPERM;
>> >                return err;
>> >        }
>> > "
>> >
>> >> +
>> >> +       /* check mode operation */
>> >> +       if (!FFU_FEATURES(ext_csd[EXT_CSD_FFU_FEATURES])) {
>> >> +               /* restart the eMMC */
>> >> +               err = mmc_ffu_restart(card);
>> >> +               if (err) {
>> >> +                       pr_err("FFU: %s: error %d FFU install:\n",
>> >> +                               mmc_hostname(card->host), err);
>> >> +               }
>> >> +       } else {
>> >
>> > Add followings
>> > "
>> >                         ffu_data_len =
>> > ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG]|
>> >                                 ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 1]
>> > << 8
>> > |
>> >                                 ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 2]
>> > <<
>> > 16 |
>> >                                 ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 3]
>> > <<
>> > 24;
>> >
>> >                         if (!ffu_data_len) {
>> >                                 err = -EPERM;
>> >                                 return err;
>> >                         }
>> > "
>> >
>> >> +                       /* set device to FFU mode */
>> >> +                       err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> >> +                               EXT_CSD_MODE_CONFIG, 0x1,
>> >> +                               card->ext_csd.generic_cmd6_time);
>> >> +                       if (err) {
>> >> +                               pr_err("FFU: %s: error %d FFU is not
>> > supported\n",
>> >> +                                       mmc_hostname(card->host), err);
>> >> +                               goto exit;
>> >> +                       }
>> >
>> >
>> >
>> > Checking ffu status in ext_csd should be done even if device does not
>> > support MODE_OPERATION_CODES So, it's better to move the code for
>> > checking
>> > this value to out of brace for
>> > FFU_FEATURES(ext_csd[EXT_CSD_FFU_FEATURES]
>> >
>> >> +                       /* set ext_csd to install mode */
>> >> +                       err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> >> +                               EXT_CSD_MODE_OPERATION_CODES,
>> >> +                               MMC_FFU_INSTALL_SET, timeout);
>> >> +
>> >> +                       if (err) {
>> >> +                               pr_err("FFU: %s: error %d setting
>> >> install
>> > mode\n",
>> >> +                                       mmc_hostname(card->host), err);
>> >> +                               goto exit;
>> >> +                       }
>> >> +
>> >
>> > Remove followings
>> > "
>> >                        /* read ext_csd */
>> >                        err = mmc_send_ext_csd(card, ext_csd);
>> >                        if (err) {
>> >                                pr_err("FFU: %s: error %d sending
>> > ext_csd\n",
>> >                                        mmc_hostname(card->host), err);
>> >                                goto exit;
>> >                        }
>> >                        /* return status */
>> >                        err = ext_csd[EXT_CSD_FFU_STATUS];
>> >                        if (err) {
>> >                                pr_err("FFU: %s: error %d FFU
>> > install:\n",
>> >                                        mmc_hostname(card->host), err);
>> >                                err = -EINVAL;
>> >                                goto exit;
>> >                        }
>> > "
>> >
>> >> +               }
>> >> +
>> >
>> > Add followings
>> > "
>> >            /* read ext_csd */
>> >            err = mmc_send_ext_csd(card, ext_csd);
>> >            if (err) {
>> >                    pr_err("FFU: %s: error %d sending ext_csd\n",
>> >                               mmc_hostname(card->host), err);
>> >                    goto exit;
>> >            }
>> >            /* return status */
>> >            err = ext_csd[EXT_CSD_FFU_STATUS];
>> >            if (err) {
>> >                    pr_err("FFU: %s: error %d FFU install:\n",
>> >                               mmc_hostname(card->host), err);
>> >                    err = -EINVAL;
>> >                    goto exit;
>> >            }
>> > "
>> >
>> >> +exit:
>> >> +       return err;
>> >> +}
>> >> +EXPORT_SYMBOL(mmc_ffu_install);
>> >> +
>> >
>> >
>> >
>> > And some device's fw should be transferred with one command.
>> > They does not support multiple commands for fw transfer.
>> > For these devices, MMC_IOC_MAX_BYTES should be greater.
>> >
>> > diff --git a/include/uapi/linux/mmc/ioctl.h
>> > b/include/uapi/linux/mmc/ioctl.h
>> > index 1f5e689..af9ea62 100644
>> > --- a/include/uapi/linux/mmc/ioctl.h
>> > +++ b/include/uapi/linux/mmc/ioctl.h
>> > @@ -53,5 +53,5 @@ struct mmc_ioc_cmd {
>> >   * is enforced per ioctl call.  For larger data transfers, use the
>> > normal
>> >   * block device operations.
>> >   */
>> > -#define MMC_IOC_MAX_BYTES  (512L * 256)
>> > +#define MMC_IOC_MAX_BYTES  (512L * 1024)
>> >  #endif /* LINUX_MMC_IOCTL_H */
>> >
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
