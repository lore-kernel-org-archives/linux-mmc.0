From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [bug report] mmc: bcm2835: Add new driver for the sdhost controller.
Date: Fri, 24 Mar 2017 08:24:44 +0100
Message-ID: <CAPDyKFobLuDx_khgBiKj6B5i9oMYqBJkow+oikCR5qbft5FNUg@mail.gmail.com>
References: <20170321201400.GA22118@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:34801 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbdCXHZ7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Mar 2017 03:25:59 -0400
Received: by mail-vk0-f47.google.com with SMTP id z204so6491801vkd.1
        for <linux-mmc@vger.kernel.org>; Fri, 24 Mar 2017 00:24:46 -0700 (PDT)
In-Reply-To: <20170321201400.GA22118@mwanda>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eric Anholt <eric@anholt.net>, Gerd Hoffmann <kraxel@redhat.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>

+Gerd

On 21 March 2017 at 21:14, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> Hello Eric Anholt,
>
> This is a semi-automatic email about new static checker warnings.
>
> The patch 5aa25d971ab4: "mmc: bcm2835: Add new driver for the sdhost
> controller." from Mar 8, 2017, leads to the following Smatch
> complaint:
>
> drivers/mmc/host/bcm2835.c:1203 bcm2835_request()
>          error: we previously assumed 'host->mrq->data' could be null (see line 1186)
>
> drivers/mmc/host/bcm2835.c
>   1156  static void bcm2835_request(struct mmc_host *mmc, struct mmc_request *mrq)
>   1157  {
>   1158          struct bcm2835_host *host = mmc_priv(mmc);
>   1159          struct device *dev = &host->pdev->dev;
>   1160          u32 edm, fsm;
>   1161
>   1162          /* Reset the error statuses in case this is a retry */
>   1163          if (mrq->sbc)
>   1164                  mrq->sbc->error = 0;
>   1165          if (mrq->cmd)
>   1166                  mrq->cmd->error = 0;
>   1167          if (mrq->data)
>   1168                  mrq->data->error = 0;
>   1169          if (mrq->stop)
>   1170                  mrq->stop->error = 0;
>   1171
>   1172          if (mrq->data && !is_power_of_2(mrq->data->blksz)) {
>                     ^^^^^^^^^
> Tested here.
>
>   1173                  dev_err(dev, "unsupported block size (%d bytes)\n",
>   1174                          mrq->data->blksz);
>   1175                  mrq->cmd->error = -EINVAL;
>   1176                  mmc_request_done(mmc, mrq);
>   1177                  return;
>   1178          }
>   1179
>   1180          if (host->use_dma && mrq->data && (mrq->data->blocks > PIO_THRESHOLD))
>                                      ^^^^^^^^^
> And here.
>
>   1181                  bcm2835_prepare_dma(host, mrq->data);
>   1182
>   1183          mutex_lock(&host->mutex);
>   1184
>   1185          WARN_ON(host->mrq);
>   1186          host->mrq = mrq;
>
> Now host->mrq->data is possibly NULL.
>
>   1187
>   1188          edm = readl(host->ioaddr + SDEDM);
>   1189          fsm = edm & SDEDM_FSM_MASK;
>   1190
>   1191          if ((fsm != SDEDM_FSM_IDENTMODE) &&
>   1192              (fsm != SDEDM_FSM_DATAMODE)) {
>   1193                  dev_err(dev, "previous command (%d) not complete (EDM %08x)\n",
>   1194                          readl(host->ioaddr + SDCMD) & SDCMD_CMD_MASK,
>   1195                          edm);
>   1196                  bcm2835_dumpregs(host);
>   1197                  mrq->cmd->error = -EILSEQ;
>   1198                  bcm2835_finish_request(host);
>   1199                  mutex_unlock(&host->mutex);
>   1200                  return;
>   1201          }
>   1202
>   1203          host->use_sbc = !!mrq->sbc && (host->mrq->data->flags & MMC_DATA_READ);
>                                                ^^^^^^^^^^^^^^^^^
> Dereferenced without a test.
>
>   1204          if (host->use_sbc) {
>   1205                  if (bcm2835_send_command(host, mrq->sbc)) {
>
> regards,
> dan carpenter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Gerd, Eric - can you please look into posting a fix for this!?

Kind regards
Uffe
