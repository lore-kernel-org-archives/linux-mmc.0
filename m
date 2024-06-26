Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA08535BF;
	Wed, 26 Jun 2024 03:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719372782; cv=none; b=uar0fPZ4/Acmu2oJf3jouigyqYTLVmgokvmaj11kssqA6cRO+LQQsI1ixG3UOkKPDT+l29qQTxROn9VGuZOm8/2/FXOqKTFPcOR1+p/9F7t/xj9d9qKnc8qxmcFPceXg00N8xt/7htKb5DVzfdpQsf3NsLDA19w9Z0ViYIthU6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719372782; c=relaxed/simple;
	bh=CglEF42gZtjA5bczlysa4tRrzJwTPkvJIKyPk4VmmUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XvawkHjQTSVXX7oo3AB32k+MfCtSANkNd1uQHkOMdHqYAXn4HDhw4Wfyaw/SingC4oyW6zLahJ9REWEKTFFVSuH8XjTnWnujh9dngEqlZA7svudk3zm0PdZCximv5VlJ2q4RaPSokZSreJoPkRzFYbYeUd2tbaab9xiI5EJkXq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cw6q5/3t; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cw6q5/3t"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6fe7a0cb58so224997266b.1;
        Tue, 25 Jun 2024 20:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719372778; x=1719977578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/4vBj4wgy981m7U3HIQojUSAkDsHm6ccu95iL6PuKo=;
        b=cw6q5/3tBT05euQeo51zrSS27fpxvHeP7HjeO+t51ocVRC5ge/uWCfta9P4yLqpXWW
         0hguiewuJKyzjK/m0vzSfhGa695kjUnfQh539+p3DnZYkkZ+4QYqQdCJvjR5M3Imd063
         +hClZxABd3d+t4k1cksY51MlNLMwj63YbyDwiO7Pd1TFgsx5voWvqcIQYGWdSr9Jh0s3
         cYT+Yk8YZLLJAw9XcZ0571Yd9WgbLKfj7gl5/Rc7rvDW193BWeJVJT/Ntv7pJ6ItzOuk
         VHHx1eEOcbTfpM5QV8LMI9vbo8kmyZ8/CrLY+4d6BCdbrI87OtsAiGIuueZhiHSHRI/F
         xDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719372778; x=1719977578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/4vBj4wgy981m7U3HIQojUSAkDsHm6ccu95iL6PuKo=;
        b=VZ1mg6DK3gkxUOLG28YukSe3su0lnc6xzMuK1Zb2U04xG9GS2GvjbtRiSvRkVPnf2W
         BJoP6Q84VgQpyk2BZSq6YkGS5+DE9fwBg4aQTZhq3KTznAiQtwzP5v9gnpWoYm7+amDe
         01kIMxCUkNZG4Umw95zIpbDNVzSbtGNRH+NhDBEdXwK8LwEJ4t3WxeofnnlT0vgwAoFJ
         rS4+HO1Fpj9s14MaN59iQnlrWTLmJ0JjL5T49l1Sjv0+4RwF5jYNh+u3YqwVJvm54YIE
         vIXkAadcePpke960lravsBKrRnfK0YkT9i0ajbP+ySpg17ajGV6tLkj7i5iWdOV7LnjQ
         a1ig==
X-Forwarded-Encrypted: i=1; AJvYcCX/lxoqjXQM+KGiDw0r+FxjqcliW7VDP2IV5+vnGQivv7ok8Hyl14ILAAubmwZXlqw5SHf0gPC/vFrZ8W6M9CZDQDK7wocZq+VEqgLDRFhsFaoIhrwCXE2yq3NlAx8uwW2KJVtFGsxi
X-Gm-Message-State: AOJu0YyW8+45AGU5u6Xxe4Vk1hX6Uk3W/3GE36jiu+LseB2K1T9+HvxC
	cjcXgT5KphWqXSGkEw5THxmnr9vbHm0cgJRJiMtG4CMQhUrF+9b63OyjqEJ5+Zjtsql6wquULjr
	g/Mik8QtN/w325pnSMmcS1sqzkO0=
X-Google-Smtp-Source: AGHT+IGFdE1Qy3w81QBGQ3y6PjO3OPaTdRosFO4vY6X9GMRpc8H+ractPO/sNExeQWwFn+Ga0fD41WNTaLW8KG1j1MU=
X-Received: by 2002:a50:9359:0:b0:579:73b7:b4cc with SMTP id
 4fb4d7f45d1cf-57d4bd5a8c5mr8863862a12.2.1719372777090; Tue, 25 Jun 2024
 20:32:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620104444.5862-1-victorshihgli@gmail.com> <20240620104444.5862-17-victorshihgli@gmail.com>
In-Reply-To: <20240620104444.5862-17-victorshihgli@gmail.com>
From: Ben Chuang <benchuanggli@gmail.com>
Date: Wed, 26 Jun 2024 11:32:41 +0800
Message-ID: <CACT4zj8hYDPj4CGWRCzDkpraLF1gHy_+05LtHZwHb0RAgB1zSg@mail.gmail.com>
Subject: Re: [PATCH V17 16/22] mmc: sdhci-uhs2: add request() and others
To: Victor Shih <victorshihgli@gmail.com>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org, dlunev@chromium.org, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 20, 2024 at 6:45=E2=80=AFPM Victor Shih <victorshihgli@gmail.co=
m> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> This is a sdhci version of mmc's request operation.
> It covers both UHS-I and UHS-II.
>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>
> Updates in V17:
>  - Add new parameter to __sdhci_finish_data_common().
>
> Updates in V16:
>  - Remove irrelevant definition in the sdhci_calc_timeout_uhs2().
>
> Updates in V15:
>  - Adjust the parameters used in the __sdhci_uhs2_finish_command()
>    to match changes in the Patch#7.
>
> Updates in V14:
>  - Use mmc_card_uhs2() to stead sdhci_uhs2_mode() in the
>    sdhci_uhs2_request().
>
> Updates in V13:
>  - Re-order function to avoid declaration.
>  - Remove unnecessary function.
>
> Updates in V11:
>  - Drop the check mmc_card_uhs2_hd_mode(host->mmc)
>    in sdhci_uhs2_set_transfer_mode().
>
> Updates in V10:
>  - Use tmode_half_duplex to instead of uhs2_tmode0_flag
>    in sdhci_uhs2_set_transfer_mode().
>
> Updates in V9:
>  - Modify the annotations in __sdhci_uhs2_send_command().
>
> Updates in V8:
>  - Adjust the position of matching brackets in
>    sdhci_uhs2_send_command_retry().
>  - Modify CameCase definition in __sdhci_uhs2_finish_command().
>  - Modify error message in __sdhci_uhs2_finish_command().
>  - sdhci_uhs2_send_command_retry() to instead of sdhci_uhs2_send_command(=
)
>    in sdhci_uhs2_request().
>  - Use sdhci_uhs2_mode() to simplify code in sdhci_uhs2_request_atomic().
>  - Add forward declaration for sdhci_send_command().
>
> Updates in V7:
>  - Cancel export state of some functions.
>  - Remove unnecessary whitespace changes.
>
> Updates in V6:
>  - Add uhs2_dev_cmd() to simplify code.
>  - Remove unnecessary functions.
>  - Cancel export state of some functions.
>  - Drop use CONFIG_MMC_DEBUG().
>  - Wrap at 100 columns in some functions.
>
> ---
>
>  drivers/mmc/host/sdhci-uhs2.c | 377 ++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.c      |  53 +++--
>  drivers/mmc/host/sdhci.h      |   8 +
>  3 files changed, 422 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.=
c
> index a521e3dbfca7..31486e28496d 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -14,6 +14,8 @@
>  #include <linux/module.h>
>  #include <linux/iopoll.h>
>  #include <linux/bitfield.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/host.h>
>
>  #include "sdhci.h"
>  #include "sdhci-uhs2.h"
> @@ -29,6 +31,8 @@
>  #define UHS2_INTERFACE_DETECT_TIMEOUT_100MS    100000
>  #define UHS2_LANE_SYNC_TIMEOUT_150MS           150000
>
> +#define UHS2_ARG_IOADR_MASK 0xfff
> +
>  void sdhci_uhs2_dump_regs(struct sdhci_host *host)
>  {
>         if (!(mmc_card_uhs2(host->mmc)))
> @@ -63,6 +67,11 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
>   *                                                                      =
     *
>  \***********************************************************************=
******/
>
> +static inline u16 uhs2_dev_cmd(struct mmc_command *cmd)
> +{
> +       return be16_to_cpu((__be16)cmd->uhs2_cmd->arg) & UHS2_ARG_IOADR_M=
ASK;
> +}
> +
>  static inline int mmc_opt_regulator_set_ocr(struct mmc_host *mmc,
>                                             struct regulator *supply,
>                                             unsigned short vdd_bit)
> @@ -528,6 +537,373 @@ static int sdhci_uhs2_control(struct mmc_host *mmc,=
 enum sd_uhs2_operation op)
>         return err;
>  }
>
> +/***********************************************************************=
******\
> + *                                                                      =
     *
> + * Core functions                                                       =
     *
> + *                                                                      =
     *
> +\***********************************************************************=
******/
> +
> +static void sdhci_uhs2_prepare_data(struct sdhci_host *host, struct mmc_=
command *cmd)
> +{
> +       struct mmc_data *data =3D cmd->data;
> +
> +       sdhci_initialize_data(host, data);
> +
> +       sdhci_prepare_dma(host, data);
> +
> +       sdhci_writew(host, data->blksz, SDHCI_UHS2_BLOCK_SIZE);
> +       sdhci_writew(host, data->blocks, SDHCI_UHS2_BLOCK_COUNT);
> +}
> +
> +static void sdhci_uhs2_finish_data(struct sdhci_host *host)
> +{
> +       struct mmc_data *data =3D host->data;
> +
> +       __sdhci_finish_data_common(host, true);
> +
> +       __sdhci_finish_mrq(host, data->mrq);
> +}
> +
> +static void sdhci_uhs2_set_transfer_mode(struct sdhci_host *host, struct=
 mmc_command *cmd)
> +{
> +       u16 mode;
> +       struct mmc_data *data =3D cmd->data;
> +
> +       if (!data) {
> +               /* clear Auto CMD settings for no data CMDs */
> +               if (uhs2_dev_cmd(cmd) =3D=3D UHS2_DEV_CMD_TRANS_ABORT) {
> +                       mode =3D  0;
> +               } else {
> +                       mode =3D sdhci_readw(host, SDHCI_UHS2_TRANS_MODE)=
;
> +                       if (cmd->opcode =3D=3D MMC_STOP_TRANSMISSION || c=
md->opcode =3D=3D MMC_ERASE)
> +                               mode |=3D SDHCI_UHS2_TRNS_WAIT_EBSY;
> +                       else
> +                               /* send status mode */
> +                               if (cmd->opcode =3D=3D MMC_SEND_STATUS)
> +                                       mode =3D 0;
> +               }
> +
> +               DBG("UHS2 no data trans mode is 0x%x.\n", mode);
> +
> +               sdhci_writew(host, mode, SDHCI_UHS2_TRANS_MODE);
> +               return;
> +       }
> +
> +       WARN_ON(!host->data);
> +
> +       mode =3D SDHCI_UHS2_TRNS_BLK_CNT_EN | SDHCI_UHS2_TRNS_WAIT_EBSY;
> +       if (data->flags & MMC_DATA_WRITE)
> +               mode |=3D SDHCI_UHS2_TRNS_DATA_TRNS_WRT;
> +
> +       if (data->blocks =3D=3D 1 &&
> +           data->blksz !=3D 512 &&
> +           cmd->opcode !=3D MMC_READ_SINGLE_BLOCK &&
> +           cmd->opcode !=3D MMC_WRITE_BLOCK) {
> +               mode &=3D ~SDHCI_UHS2_TRNS_BLK_CNT_EN;
> +               mode |=3D SDHCI_UHS2_TRNS_BLK_BYTE_MODE;
> +       }
> +
> +       if (host->flags & SDHCI_REQ_USE_DMA)
> +               mode |=3D SDHCI_UHS2_TRNS_DMA;
> +
> +       if (cmd->uhs2_cmd->tmode_half_duplex)
> +               mode |=3D SDHCI_UHS2_TRNS_2L_HD;
> +
> +       sdhci_writew(host, mode, SDHCI_UHS2_TRANS_MODE);
> +
> +       DBG("UHS2 trans mode is 0x%x.\n", mode);
> +}
> +
> +static void __sdhci_uhs2_send_command(struct sdhci_host *host, struct mm=
c_command *cmd)
> +{
> +       int i, j;
> +       int cmd_reg;
> +
> +       i =3D 0;
> +       sdhci_writel(host,
> +                    ((u32)cmd->uhs2_cmd->arg << 16) |
> +                               (u32)cmd->uhs2_cmd->header,
> +                    SDHCI_UHS2_CMD_PACKET + i);
> +       i +=3D 4;
> +
> +       /*
> +        * Per spec, payload (config) should be MSB before sending out.
> +        * But we don't need convert here because had set payload as
> +        * MSB when preparing config read/write commands.
> +        */
> +       for (j =3D 0; j < cmd->uhs2_cmd->payload_len / sizeof(u32); j++) =
{
> +               sdhci_writel(host, *(cmd->uhs2_cmd->payload + j), SDHCI_U=
HS2_CMD_PACKET + i);
> +               i +=3D 4;
> +       }
> +
> +       for ( ; i < SDHCI_UHS2_CMD_PACK_MAX_LEN; i +=3D 4)
> +               sdhci_writel(host, 0, SDHCI_UHS2_CMD_PACKET + i);
> +
> +       DBG("UHS2 CMD packet_len =3D %d.\n", cmd->uhs2_cmd->packet_len);
> +       for (i =3D 0; i < cmd->uhs2_cmd->packet_len; i++)
> +               DBG("UHS2 CMD_PACKET[%d] =3D 0x%x.\n", i,
> +                   sdhci_readb(host, SDHCI_UHS2_CMD_PACKET + i));
> +
> +       cmd_reg =3D FIELD_PREP(SDHCI_UHS2_CMD_PACK_LEN_MASK, cmd->uhs2_cm=
d->packet_len);
> +       if ((cmd->flags & MMC_CMD_MASK) =3D=3D MMC_CMD_ADTC)
> +               cmd_reg |=3D SDHCI_UHS2_CMD_DATA;
> +       if (cmd->opcode =3D=3D MMC_STOP_TRANSMISSION)
> +               cmd_reg |=3D SDHCI_UHS2_CMD_CMD12;
> +
> +       /* UHS2 Native ABORT */
> +       if ((cmd->uhs2_cmd->header & UHS2_NATIVE_PACKET) &&
> +           (uhs2_dev_cmd(cmd) =3D=3D UHS2_DEV_CMD_TRANS_ABORT))
> +               cmd_reg |=3D SDHCI_UHS2_CMD_TRNS_ABORT;
> +
> +       /* UHS2 Native DORMANT */
> +       if ((cmd->uhs2_cmd->header & UHS2_NATIVE_PACKET) &&
> +           (uhs2_dev_cmd(cmd) =3D=3D UHS2_DEV_CMD_GO_DORMANT_STATE))
> +               cmd_reg |=3D SDHCI_UHS2_CMD_DORMANT;
> +
> +       DBG("0x%x is set to UHS2 CMD register.\n", cmd_reg);
> +
> +       sdhci_writew(host, cmd_reg, SDHCI_UHS2_CMD);
> +}
> +
> +static bool sdhci_uhs2_send_command(struct sdhci_host *host, struct mmc_=
command *cmd)
> +{
> +       int flags;
> +       u32 mask;
> +       unsigned long timeout;
> +
> +       WARN_ON(host->cmd);
> +
> +       /* Initially, a command has no error */
> +       cmd->error =3D 0;
> +
> +       if (cmd->opcode =3D=3D MMC_STOP_TRANSMISSION)
> +               cmd->flags |=3D MMC_RSP_BUSY;
> +
> +       mask =3D SDHCI_CMD_INHIBIT;
> +
> +       if (sdhci_readl(host, SDHCI_PRESENT_STATE) & mask)
> +               return false;
> +
> +       host->cmd =3D cmd;
> +       host->data_timeout =3D 0;
> +       if (sdhci_data_line_cmd(cmd)) {
> +               WARN_ON(host->data_cmd);
> +               host->data_cmd =3D cmd;
> +               __sdhci_uhs2_set_timeout(host);
> +       }
> +
> +       if (cmd->data)
> +               sdhci_uhs2_prepare_data(host, cmd);
> +
> +       sdhci_uhs2_set_transfer_mode(host, cmd);
> +
> +       if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
> +               WARN_ONCE(1, "Unsupported response type!\n");
> +               /*
> +                * This does not happen in practice because 136-bit respo=
nse
> +                * commands never have busy waiting, so rather than compl=
icate
> +                * the error path, just remove busy waiting and continue.
> +                */
> +               cmd->flags &=3D ~MMC_RSP_BUSY;
> +       }
> +
> +       if (!(cmd->flags & MMC_RSP_PRESENT))
> +               flags =3D SDHCI_CMD_RESP_NONE;
> +       else if (cmd->flags & MMC_RSP_136)
> +               flags =3D SDHCI_CMD_RESP_LONG;
> +       else if (cmd->flags & MMC_RSP_BUSY)
> +               flags =3D SDHCI_CMD_RESP_SHORT_BUSY;
> +       else
> +               flags =3D SDHCI_CMD_RESP_SHORT;
> +
> +       if (cmd->flags & MMC_RSP_CRC)
> +               flags |=3D SDHCI_CMD_CRC;
> +       if (cmd->flags & MMC_RSP_OPCODE)
> +               flags |=3D SDHCI_CMD_INDEX;
> +
> +       timeout =3D jiffies;
> +       if (host->data_timeout)
> +               timeout +=3D nsecs_to_jiffies(host->data_timeout);
> +       else if (!cmd->data && cmd->busy_timeout > 9000)
> +               timeout +=3D DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ +=
 HZ;
> +       else
> +               timeout +=3D 10 * HZ;
> +       sdhci_mod_timer(host, cmd->mrq, timeout);
> +
> +       __sdhci_uhs2_send_command(host, cmd);
> +
> +       return true;
> +}
> +
> +static bool sdhci_uhs2_send_command_retry(struct sdhci_host *host,
> +                                         struct mmc_command *cmd,
> +                                         unsigned long flags)
> +       __releases(host->lock)
> +       __acquires(host->lock)
> +{
> +       struct mmc_command *deferred_cmd =3D host->deferred_cmd;
> +       int timeout =3D 10; /* Approx. 10 ms */
> +       bool present;
> +
> +       while (!sdhci_uhs2_send_command(host, cmd)) {
> +               if (!timeout--) {
> +                       pr_err("%s: Controller never released inhibit bit=
(s).\n",
> +                              mmc_hostname(host->mmc));
> +                       sdhci_dumpregs(host);
> +                       cmd->error =3D -EIO;
> +                       return false;
> +               }
> +
> +               spin_unlock_irqrestore(&host->lock, flags);
> +
> +               usleep_range(1000, 1250);
> +
> +               present =3D host->mmc->ops->get_cd(host->mmc);
> +
> +               spin_lock_irqsave(&host->lock, flags);
> +
> +               /* A deferred command might disappear, handle that */
> +               if (cmd =3D=3D deferred_cmd && cmd !=3D host->deferred_cm=
d)
> +                       return true;
> +
> +               if (sdhci_present_error(host, cmd, present))
> +                       return false;
> +       }
> +
> +       if (cmd =3D=3D host->deferred_cmd)
> +               host->deferred_cmd =3D NULL;
> +
> +       return true;
> +}
> +
> +static void __sdhci_uhs2_finish_command(struct sdhci_host *host)
> +{
> +       struct mmc_command *cmd =3D host->cmd;
> +       u8 resp;
> +       u8 error_code;
> +       bool breada0 =3D 0;
> +       int i;
> +
> +       if (host->mmc->uhs2_sd_tran) {
> +               resp =3D sdhci_readb(host, SDHCI_UHS2_RESPONSE + 2);
> +               if (resp & UHS2_RES_NACK_MASK) {
> +                       error_code =3D (resp >> UHS2_RES_ECODE_POS) & UHS=
2_RES_ECODE_MASK;
> +                       pr_err("%s: NACK response, ECODE=3D0x%x.\n",
> +                              mmc_hostname(host->mmc), error_code);
> +               }
> +               breada0 =3D 1;
> +       }
> +
> +       if (cmd->uhs2_cmd->uhs2_resp &&

FYI. When compiling the patch, the compiler will show the following message=
s.
--
drivers/mmc/host/sdhci-uhs2.c: In function =E2=80=98__sdhci_uhs2_finish_com=
mand=E2=80=99:
drivers/mmc/host/sdhci-uhs2.c:814:13: error: the comparison will
always evaluate as =E2=80=98true=E2=80=99 for the address of =E2=80=98uhs2_=
resp=E2=80=99 will never be
NULL [-Werror=3Daddress]
  814 |         if (cmd->uhs2_cmd->uhs2_resp &&
      |             ^~~
In file included from ./include/linux/mmc/host.h:14,
                 from drivers/mmc/host/sdhci-uhs2.c:18:
./include/linux/mmc/core.h:36:17: note: =E2=80=98uhs2_resp=E2=80=99 declare=
d here
   36 |         u8      uhs2_resp[UHS2_MAX_RESP_LEN];   /* UHS2 native
cmd resp */
      |                 ^~~~~~~~~
cc1: all warnings being treated as errors
make[5]: *** [scripts/Makefile.build:244: drivers/mmc/host/sdhci-uhs2.o] Er=
ror 1
--

Best regards,
Ben Chuang

> +           cmd->uhs2_cmd->uhs2_resp_len && cmd->uhs2_cmd->uhs2_resp_len =
<=3D 20) {
> +               /* Get whole response of some native CCMD, like
> +                * DEVICE_INIT, ENUMERATE.
> +                */
> +               for (i =3D 0; i < cmd->uhs2_cmd->uhs2_resp_len; i++)
> +                       cmd->uhs2_cmd->uhs2_resp[i] =3D sdhci_readb(host,=
 SDHCI_UHS2_RESPONSE + i);
> +       } else {
> +               /* Get SD CMD response and Payload for some read
> +                * CCMD, like INQUIRY_CFG.
> +                */
> +               /* Per spec (p136), payload field is divided into
> +                * a unit of DWORD and transmission order within
> +                * a DWORD is big endian.
> +                */
> +               if (!breada0)
> +                       sdhci_readl(host, SDHCI_UHS2_RESPONSE);
> +               for (i =3D 4; i < 20; i +=3D 4) {
> +                       cmd->resp[i / 4 - 1] =3D
> +                               (sdhci_readb(host,
> +                                            SDHCI_UHS2_RESPONSE + i) << =
24) |
> +                               (sdhci_readb(host,
> +                                            SDHCI_UHS2_RESPONSE + i + 1)
> +                                       << 16) |
> +                               (sdhci_readb(host,
> +                                            SDHCI_UHS2_RESPONSE + i + 2)
> +                                       << 8) |
> +                               sdhci_readb(host, SDHCI_UHS2_RESPONSE + i=
 + 3);
> +               }
> +       }
> +}
> +
> +static void sdhci_uhs2_finish_command(struct sdhci_host *host)
> +{
> +       struct mmc_command *cmd =3D host->cmd;
> +
> +       __sdhci_uhs2_finish_command(host);
> +
> +       host->cmd =3D NULL;
> +
> +       if (cmd->mrq->cap_cmd_during_tfr && cmd =3D=3D cmd->mrq->cmd)
> +               mmc_command_done(host->mmc, cmd->mrq);
> +
> +       /*
> +        * The host can send and interrupt when the busy state has
> +        * ended, allowing us to wait without wasting CPU cycles.
> +        * The busy signal uses DAT0 so this is similar to waiting
> +        * for data to complete.
> +        *
> +        * Note: The 1.0 specification is a bit ambiguous about this
> +        *       feature so there might be some problems with older
> +        *       controllers.
> +        */
> +       if (cmd->flags & MMC_RSP_BUSY) {
> +               if (cmd->data) {
> +                       DBG("Cannot wait for busy signal when also doing =
a data transfer");
> +               } else if (!(host->quirks & SDHCI_QUIRK_NO_BUSY_IRQ) &&
> +                          cmd =3D=3D host->data_cmd) {
> +                       /* Command complete before busy is ended */
> +                       return;
> +               }
> +       }
> +
> +       /* Processed actual command. */
> +       if (host->data && host->data_early)
> +               sdhci_uhs2_finish_data(host);
> +
> +       if (!cmd->data)
> +               __sdhci_finish_mrq(host, cmd->mrq);
> +}
> +
> +static void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request =
*mrq)
> +{
> +       struct sdhci_host *host =3D mmc_priv(mmc);
> +       struct mmc_command *cmd;
> +       unsigned long flags;
> +       bool present;
> +
> +       if (!(mmc_card_uhs2(mmc))) {
> +               sdhci_request(mmc, mrq);
> +               return;
> +       }
> +
> +       mrq->stop =3D NULL;
> +       mrq->sbc =3D NULL;
> +       if (mrq->data)
> +               mrq->data->stop =3D NULL;
> +
> +       /* Firstly check card presence */
> +       present =3D mmc->ops->get_cd(mmc);
> +
> +       spin_lock_irqsave(&host->lock, flags);
> +
> +       if (sdhci_present_error(host, mrq->cmd, present))
> +               goto out_finish;
> +
> +       cmd =3D mrq->cmd;
> +
> +       if (!sdhci_uhs2_send_command_retry(host, cmd, flags))
> +               goto out_finish;
> +
> +       spin_unlock_irqrestore(&host->lock, flags);
> +
> +       return;
> +
> +out_finish:
> +       sdhci_finish_mrq(host, mrq);
> +       spin_unlock_irqrestore(&host->lock, flags);
> +}
> +
>  /***********************************************************************=
******\
>   *                                                                      =
     *
>   * Driver init/exit                                                     =
     *
> @@ -537,6 +913,7 @@ static int sdhci_uhs2_control(struct mmc_host *mmc, e=
num sd_uhs2_operation op)
>  static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
>  {
>         host->mmc_host_ops.uhs2_control =3D sdhci_uhs2_control;
> +       host->mmc_host_ops.request =3D sdhci_uhs2_request;
>
>         return 0;
>  }
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index d69bdec35b08..4eff8a9f6b9a 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -147,10 +147,11 @@ void sdhci_enable_v4_mode(struct sdhci_host *host)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_enable_v4_mode);
>
> -static inline bool sdhci_data_line_cmd(struct mmc_command *cmd)
> +bool sdhci_data_line_cmd(struct mmc_command *cmd)
>  {
>         return cmd->data || cmd->flags & MMC_RSP_BUSY;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_data_line_cmd);
>
>  static void sdhci_set_card_detection(struct sdhci_host *host, bool enabl=
e)
>  {
> @@ -502,14 +503,15 @@ static inline void sdhci_led_deactivate(struct sdhc=
i_host *host)
>
>  #endif
>
> -static void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request =
*mrq,
> -                           unsigned long timeout)
> +void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,
> +                    unsigned long timeout)
>  {
>         if (sdhci_data_line_cmd(mrq->cmd))
>                 mod_timer(&host->data_timer, timeout);
>         else
>                 mod_timer(&host->timer, timeout);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_mod_timer);
>
>  static void sdhci_del_timer(struct sdhci_host *host, struct mmc_request =
*mrq)
>  {
> @@ -1076,8 +1078,7 @@ static void sdhci_set_timeout(struct sdhci_host *ho=
st, struct mmc_command *cmd)
>                 __sdhci_set_timeout(host, cmd);
>  }
>
> -static void sdhci_initialize_data(struct sdhci_host *host,
> -                                 struct mmc_data *data)
> +void sdhci_initialize_data(struct sdhci_host *host, struct mmc_data *dat=
a)
>  {
>         WARN_ON(host->data);
>
> @@ -1090,6 +1091,7 @@ static void sdhci_initialize_data(struct sdhci_host=
 *host,
>         host->data_early =3D 0;
>         host->data->bytes_xfered =3D 0;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_initialize_data);
>
>  static inline void sdhci_set_block_info(struct sdhci_host *host,
>                                         struct mmc_data *data)
> @@ -1112,12 +1114,8 @@ static inline void sdhci_set_block_info(struct sdh=
ci_host *host,
>         }
>  }
>
> -static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_comma=
nd *cmd)
> +void sdhci_prepare_dma(struct sdhci_host *host, struct mmc_data *data)
>  {
> -       struct mmc_data *data =3D cmd->data;
> -
> -       sdhci_initialize_data(host, data);
> -
>         if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
>                 struct scatterlist *sg;
>                 unsigned int length_mask, offset_mask;
> @@ -1202,6 +1200,16 @@ static void sdhci_prepare_data(struct sdhci_host *=
host, struct mmc_command *cmd)
>         }
>
>         sdhci_set_transfer_irqs(host);
> +}
> +EXPORT_SYMBOL_GPL(sdhci_prepare_dma);
> +
> +static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_comma=
nd *cmd)
> +{
> +       struct mmc_data *data =3D cmd->data;
> +
> +       sdhci_initialize_data(host, data);
> +
> +       sdhci_prepare_dma(host, data);
>
>         sdhci_set_block_info(host, data);
>  }
> @@ -1519,7 +1527,7 @@ static void sdhci_set_mrq_done(struct sdhci_host *h=
ost, struct mmc_request *mrq)
>         WARN_ON(i >=3D SDHCI_MAX_MRQS);
>  }
>
> -static void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_reque=
st *mrq)
> +void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq=
)
>  {
>         if (host->cmd && host->cmd->mrq =3D=3D mrq)
>                 host->cmd =3D NULL;
> @@ -1543,15 +1551,17 @@ static void __sdhci_finish_mrq(struct sdhci_host =
*host, struct mmc_request *mrq)
>         if (!sdhci_has_requests(host))
>                 sdhci_led_deactivate(host);
>  }
> +EXPORT_SYMBOL_GPL(__sdhci_finish_mrq);
>
> -static void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request=
 *mrq)
> +void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
>  {
>         __sdhci_finish_mrq(host, mrq);
>
>         queue_work(host->complete_wq, &host->complete_work);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_finish_mrq);
>
> -static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_ti=
meout)
> +void __sdhci_finish_data_common(struct sdhci_host *host, bool defer_rese=
t)
>  {
>         struct mmc_command *data_cmd =3D host->data_cmd;
>         struct mmc_data *data =3D host->data;
> @@ -1564,7 +1574,9 @@ static void __sdhci_finish_data(struct sdhci_host *=
host, bool sw_data_timeout)
>          * conditions.
>          */
>         if (data->error) {
> -               if (!host->cmd || host->cmd =3D=3D data_cmd)
> +               if (defer_reset)
> +                       host->pending_reset =3D true;
> +               else if (!host->cmd || host->cmd =3D=3D data_cmd)
>                         sdhci_reset_for(host, REQUEST_ERROR);
>                 else
>                         sdhci_reset_for(host, REQUEST_ERROR_DATA_ONLY);
> @@ -1585,6 +1597,14 @@ static void __sdhci_finish_data(struct sdhci_host =
*host, bool sw_data_timeout)
>                 data->bytes_xfered =3D 0;
>         else
>                 data->bytes_xfered =3D data->blksz * data->blocks;
> +}
> +EXPORT_SYMBOL_GPL(__sdhci_finish_data_common);
> +
> +static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_ti=
meout)
> +{
> +       struct mmc_data *data =3D host->data;
> +
> +       __sdhci_finish_data_common(host, false);
>
>         /*
>          * Need to send CMD12 if -
> @@ -1719,8 +1739,8 @@ static bool sdhci_send_command(struct sdhci_host *h=
ost, struct mmc_command *cmd)
>         return true;
>  }
>
> -static bool sdhci_present_error(struct sdhci_host *host,
> -                               struct mmc_command *cmd, bool present)
> +bool sdhci_present_error(struct sdhci_host *host,
> +                        struct mmc_command *cmd, bool present)
>  {
>         if (!present || host->flags & SDHCI_DEVICE_DEAD) {
>                 cmd->error =3D -ENOMEDIUM;
> @@ -1729,6 +1749,7 @@ static bool sdhci_present_error(struct sdhci_host *=
host,
>
>         return false;
>  }
> +EXPORT_SYMBOL_GPL(sdhci_present_error);
>
>  static bool sdhci_send_command_retry(struct sdhci_host *host,
>                                      struct mmc_command *cmd,
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 89d4f070508e..3a68fd1e4bd3 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -829,6 +829,14 @@ static inline void sdhci_read_caps(struct sdhci_host=
 *host)
>         __sdhci_read_caps(host, NULL, NULL, NULL);
>  }
>
> +bool sdhci_data_line_cmd(struct mmc_command *cmd);
> +void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq, u=
nsigned long timeout);
> +void sdhci_initialize_data(struct sdhci_host *host, struct mmc_data *dat=
a);
> +void sdhci_prepare_dma(struct sdhci_host *host, struct mmc_data *data);
> +void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq=
);
> +void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
> +void __sdhci_finish_data_common(struct sdhci_host *host, bool defer_rese=
t);
> +bool sdhci_present_error(struct sdhci_host *host, struct mmc_command *cm=
d, bool present);
>  u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
>                    unsigned int *actual_clock);
>  void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
> --
> 2.25.1
>
