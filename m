From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH v4] mmc: core: select the operation mode with sysfs
Date: Mon, 6 Feb 2012 13:19:46 +0900
Message-ID: <CAKYAXd_LDUKQHDN7p44921n4uym9kOSoF2dGrGSr6vJ_19-2jw@mail.gmail.com>
References: <4F2F3D14.6060204@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59266 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753454Ab2BFETs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 5 Feb 2012 23:19:48 -0500
Received: by bkcjm19 with SMTP id jm19so4357771bkc.19
        for <linux-mmc@vger.kernel.org>; Sun, 05 Feb 2012 20:19:47 -0800 (PST)
In-Reply-To: <4F2F3D14.6060204@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

Hi. Jaehoon.

I have questions.

1. Would you explain why we need on/off function of this CMD23 at runti=
me ?
2. While frequently reading/writing, Have you tested by being
enabling/disbling CMD23 using this function ?
3. Why is irq disable needed when calling mmc_change_operation_mode ?
If are we just using spin_lock ?
4. When do we use host->pre_defined_op value after setting it ?

Thanks.

2012/2/6 Jaehoon Chung <jh80.chung@samsung.com>:
> This patch is support the sysfs for operation mode.
>
> There are two operation modes(open-ended/pre-defined).
> Now, operation mode is selected only one at the compile time.
>
> But using this patch, we can change the operation mode with node at r=
untime.
>
> * pre-defined mode
> echo 1 > /sys/class/mmc_host/mmc0/pre_defined_op
> * open-ended mode
> echo 0 > /sys/class/mmc_host/mmc0/pre_defined_op
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> Changelog V4:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0- Add the explanation in Documentation/mmc=
/mmc-dev-attrs.txt
> Changelog V3:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0- Add the mmc_change_operation_mode()
> Changelog v2:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0- Add the check point in mmc_cmd23_store()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0(If host controller didn't support CMD23, =
need not to change the ops-mode.)
>
> =C2=A0Documentation/mmc/mmc-dev-attrs.txt | =C2=A0 16 ++++++++++++++
> =C2=A0drivers/mmc/card/block.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 19 +++++++++++++++++
> =C2=A0drivers/mmc/core/host.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | =C2=A0 39 +++++++++++++++++++++++++++++++++++
> =C2=A0include/linux/mmc/card.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 =C2=A01 +
> =C2=A0include/linux/mmc/host.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 =C2=A03 ++
> =C2=A05 files changed, 78 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/mmc/mmc-dev-attrs.txt b/Documentation/mmc/=
mmc-dev-attrs.txt
> index 22ae844..e7ba3b6 100644
> --- a/Documentation/mmc/mmc-dev-attrs.txt
> +++ b/Documentation/mmc/mmc-dev-attrs.txt
> @@ -74,3 +74,19 @@ This attribute appears only if CONFIG_MMC_CLKGATE =
is enabled.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0clkgate_delay =C2=A0 Tune the clock gating=
 delay with desired value in milliseconds.
>
> =C2=A0echo <desired delay> > /sys/class/mmc_host/mmcX/clkgate_delay
> +
> +SD and MMC Operation Mode Attribute
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +SD and MMC can support the two operation mode.
> +(Pre-defined(CMD23)/Open-ended operation mode)
> +
> +This attribute can change the operation mode at runtime if card is s=
upported the CMD23.
> +
> + =C2=A0 =C2=A0 =C2=A0 pre_defined_op =C2=A0Support the pre-defined m=
ode if set 1.
> +
> +1) Open-ended mode
> +echo 0 > /sys/class/mmc_host/mmcX/pre_defined_op
> +
> +2) Pre-defined mode
> +echo 1 > /sys/class/mmc_host/mmcX/pre_defined_op
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index a7c75d8..2c1981c 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1766,6 +1766,25 @@ static const struct mmc_fixup blk_fixups[] =3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0END_FIXUP
> =C2=A0};
>
> +void mmc_change_operation_mode(struct mmc_card *card, int val)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct mmc_blk_data *md =3D mmc_get_drvdata(ca=
rd);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (mmc_host_cmd23(card->host)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mmc_card_mmc(c=
ard) ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (mmc=
_card_sd(card) &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
card->scr.cmds & SD_SCR_CMD23_SUPPORT)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (val) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 md->flags |=3D MMC_BLK_CMD23;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 card->host->pre_defined_op =3D val;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 md->flags &=3D ~MMC_BLK_CMD23;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 card->host->pre_defined_op =3D val;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
> +}
> +
> =C2=A0static int mmc_blk_probe(struct mmc_card *card)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mmc_blk_data *md, *part_md;
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 30055f2..7dab0dc 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -293,6 +293,41 @@ static inline void mmc_host_clk_sysfs_init(struc=
t mmc_host *host)
>
> =C2=A0#endif
>
> +static ssize_t mmc_cmd23_show(struct device *dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device_attr=
ibute *attr, char *buf)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct mmc_host *host =3D cls_dev_to_mmc_host(=
dev);
> + =C2=A0 =C2=A0 =C2=A0 return snprintf(buf, PAGE_SIZE, "%d\n", host->=
pre_defined_op);
> +}
> +
> +static ssize_t mmc_cmd23_store(struct device *dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device_attr=
ibute *attr, const char *buf, size_t count)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct mmc_host *host =3D cls_dev_to_mmc_host(=
dev);
> + =C2=A0 =C2=A0 =C2=A0 int value;
> + =C2=A0 =C2=A0 =C2=A0 unsigned long flags;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (kstrtoint(buf, 0, &value))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> +
> + =C2=A0 =C2=A0 =C2=A0 spin_lock_irqsave(&host->lock, flags);
> + =C2=A0 =C2=A0 =C2=A0 mmc_change_operation_mode(host->card, value);
> + =C2=A0 =C2=A0 =C2=A0 spin_unlock_irqrestore(&host->lock, flags);
> + =C2=A0 =C2=A0 =C2=A0 return count;
> +}
> +
> +static inline void mmc_host_cmd23_sysfs_init(struct mmc_host *host)
> +{
> + =C2=A0 =C2=A0 =C2=A0 host->pre_defined_attr.show =3D mmc_cmd23_show=
;
> + =C2=A0 =C2=A0 =C2=A0 host->pre_defined_attr.store =3D mmc_cmd23_sto=
re;
> + =C2=A0 =C2=A0 =C2=A0 sysfs_attr_init(&host->pre_defined_attr.attr);
> + =C2=A0 =C2=A0 =C2=A0 host->pre_defined_attr.attr.name =3D "pre_defi=
ned_op";
> + =C2=A0 =C2=A0 =C2=A0 host->pre_defined_attr.attr.mode =3D S_IRUGO |=
 S_IWUSR;
> + =C2=A0 =C2=A0 =C2=A0 if (device_create_file(&host->class_dev, &host=
->pre_defined_attr))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("%s: Failed=
 to create pre_defined_op sysfs entry\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmc_hostname(host));
> +}
> +
> =C2=A0/**
> =C2=A0* =C2=A0 =C2=A0 mmc_alloc_host - initialise the per-host struct=
ure.
> =C2=A0* =C2=A0 =C2=A0 @extra: sizeof private data structure
> @@ -381,6 +416,10 @@ int mmc_add_host(struct mmc_host *host)
> =C2=A0#endif
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mmc_host_clk_sysfs_init(host);
>
> + =C2=A0 =C2=A0 =C2=A0 if (host->caps & MMC_CAP_CMD23)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->pre_defined_=
op =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 mmc_host_cmd23_sysfs_init(host);
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mmc_start_host(host);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0register_pm_notifier(&host->pm_notify);
>
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 1a1ca71..b36d408 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -489,5 +489,6 @@ extern void mmc_unregister_driver(struct mmc_driv=
er *);
>
> =C2=A0extern void mmc_fixup_device(struct mmc_card *card,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct mmc_fixup *table);
> +extern void mmc_change_operation_mode(struct mmc_card *card, int val=
);
>
> =C2=A0#endif /* LINUX_MMC_CARD_H */
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 20d7c82..59a30bf 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -259,6 +259,9 @@ struct mmc_host {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MMC_CAP2_HS200_1_2V_SDR)
> =C2=A0#define MMC_CAP2_BROKEN_VOLTAGE =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 <=
< 7) =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Use the broken voltage */
>
> + =C2=A0 =C2=A0 =C2=A0 struct device_attribute pre_defined_attr;
> + =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pre_defined_op; /* CMD23 should be use or n=
ot */
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mmc_pm_flag_t =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 pm_caps; =C2=A0 =C2=A0 =C2=A0 =C2=A0/* supported pm features */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int =C2=A0 =C2=A0 =C2=A0 =C2=A0po=
wer_notify_type;
> =C2=A0#define MMC_HOST_PW_NOTIFY_NONE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
