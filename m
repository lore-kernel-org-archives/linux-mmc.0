Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F071C28B2B
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Aug 2022 16:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240616AbiHQQJu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 17 Aug 2022 12:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240920AbiHQQJS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Aug 2022 12:09:18 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5BBA0318
        for <linux-mmc@vger.kernel.org>; Wed, 17 Aug 2022 09:08:56 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x19so19603114lfq.7
        for <linux-mmc@vger.kernel.org>; Wed, 17 Aug 2022 09:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=QoHcNPd3wc/sIbekmUujDyF0P3kyHsDqQ+GBH4jYla4=;
        b=BPzQy22TkuhkfSdGUYYGubtaWAjnyUWUec+uq/QcIYGsjiYEfnZaL4UQ9Xw2dW6xuS
         VBUkhv238mRQ8F3t2c98wiCMIFM0Ey1Bflmp4bgJhMqGzCWrUf4yNwEvqB08X0VHi3AX
         iIP6VtZN6hppOHFnuJXp7vlKISQAZNtnUfkQT5puL/qJGrzLnjY0h0Q+CgLVnExkOq+F
         XWqhoaUawrgN6niKFsCJLfEzSL1IO9453+GemUUCiJxajGspFiWs6BXFjv6pT2EgO5nL
         v9N7lMOZczNiGpMiYV+kYK+yuWeyMRqx/JNyJUwZza9J4A5pPuQRPJs7ap1iugQvnz97
         9eog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=QoHcNPd3wc/sIbekmUujDyF0P3kyHsDqQ+GBH4jYla4=;
        b=tLauw/OzILogGMyHm3NDG7U12b0RvX+E9owMSAGAZsrXAOC1/YvyXcxDh3LCZPt3uu
         b42NaMfI/6ViAl8bi2jAdSLhNkz+5BXn49cn1p0dx/mZDIO/37pQnB99mFEAV2MkFV0Q
         BsfVK8CEjDR8VD19bY4uV5ILC2ucs+hc/TP64R20tAKwWikApzH4Nv6fo+iZ4PC9toDO
         K6IQSpG9qhkX0XibwqGfal1IuFLkF2630ZjRHY1ed30O3zR0d5LJyu0zjZviLFnk+mp8
         e3tQ2Dznb8wU5aJAS8B76PpB/NlKGg+/tFtObS1jYWFPhMIjHTvZ+wIfp0iibHVdVriS
         lMoQ==
X-Gm-Message-State: ACgBeo1RVbx5TrCRAVeWG6BrlRcgz7WjmpC5gIm99aJqneyHc8ueWS1o
        E/qpx3HJn8EAzkzEgEgo1mZ6+FpkzWE+I0r8N413qw==
X-Google-Smtp-Source: AA6agR6C+d6rL2UihKmY2lJbX13cWdEL9pkurSqwp3tje1t0XXa2CTsHUEW6HH/6aS7aesH2574C3ea8bdwQ35u/W6s=
X-Received: by 2002:a05:6512:230a:b0:48c:2e06:6c74 with SMTP id
 o10-20020a056512230a00b0048c2e066c74mr9306475lfu.358.1660752534532; Wed, 17
 Aug 2022 09:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1658719324.git.tonyhuang.sunplus@gmail.com> <511e17e91ffa16d2a26d1e77f832a0771e2c4017.1658719324.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <511e17e91ffa16d2a26d1e77f832a0771e2c4017.1658719324.git.tonyhuang.sunplus@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 17 Aug 2022 18:08:17 +0200
Message-ID: <CAPDyKFpZBSw0jM1YXF9zJ7xxwjO_HXbJ06w3vbjDEZe7=a3FOA@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] mmc: Add mmc driver for Sunplus SP7021
To:     Tony Huang <tonyhuang.sunplus@gmail.com>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kerenl@vger.kernel.org,
        p.zabel@pengutronix.de, kuba@kernel.org, davem@davemloft.net,
        colin.foster@in-advantage.com, vladimir.oltean@nxp.com,
        wells@sunplus.com, tony.huang@sunplus.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

[...]

> +struct spmmc_host {
> +       void __iomem *base;
> +       struct clk *clk;
> +       struct reset_control *rstc;
> +       spinlock_t lock; /* Prevent races with irq handler */
> +       struct mutex mrq_lock; /* protect spmmc_set_ios() context and spmmc_request() */
> +       struct mmc_host *mmc;
> +       struct mmc_request *mrq; /* current mrq */
> +       int irq;
> +       int power_state; /* current power state: off/up/on */
> +       int ddr_enabled;
> +       int signal_voltage;
> +       int dmapio_mode;
> +       /*
> +        * for purpose of reducing context switch, only when transfer data that
> +        * length is greater than `dma_int_threshold' should use interrupt
> +        */
> +       int dma_int_threshold;

I don't quite see how this is being used in the code. Is the threshold
dynamically changed or could it be defined as constant value instead?

> +       struct sg_mapping_iter sg_miter; /* for pio mode to access sglist */
> +       struct spmmc_tuning_info tuning_info;
> +};
> +
> +/*
> + * wait for transaction done, return -1 if error.
> + */
> +static inline int spmmc_wait_finish(struct spmmc_host *host)
> +{
> +       /* Wait for transaction finish */
> +       unsigned long timeout = jiffies + msecs_to_jiffies(5000);
> +
> +       while (!time_after(jiffies, timeout)) {
> +               if (readl(host->base + SPMMC_SD_STATE_REG) & SPMMC_SDSTATE_FINISH)
> +                       return 0;
> +               if (readl(host->base + SPMMC_SD_STATE_REG) & SPMMC_SDSTATE_ERROR)
> +                       return -EIO;
> +       }

Please convert the above and similar loops for timeouts for the entire
file, into using readl_poll_timeout().

Moreover, please define the timeout values as constants.

Note that, there are other places in this file where the similar loop
exists, please change them accordingly too.

[...]

> +
> +static void spmmc_send_stop_cmd(struct spmmc_host *host)
> +{
> +       struct mmc_command stop = {};
> +       u32 value;
> +
> +       stop.opcode = MMC_STOP_TRANSMISSION;
> +       stop.arg = 0;
> +       stop.flags = MMC_RSP_R1B;
> +       spmmc_prepare_cmd(host, &stop);
> +       value = readl(host->base + SPMMC_SD_INT_REG);
> +       value &= ~SPMMC_SDINT_SDCMPEN;
> +       value |= FIELD_PREP(SPMMC_SDINT_SDCMPEN, 0);
> +       writel(value, host->base + SPMMC_SD_INT_REG);
> +       spmmc_trigger_transaction(host);
> +       spmmc_wait_finish(host);
> +}
> +
> +static int spmmc_check_error(struct spmmc_host *host, struct mmc_request *mrq)
> +{
> +       int ret = 0;
> +       struct mmc_command *cmd = mrq->cmd;
> +       struct mmc_data *data = mrq->data;
> +
> +       u32 value = readl(host->base + SPMMC_SD_STATE_REG);
> +       u32 crc_token = FIELD_GET(SPMMC_CRCTOKEN_CHECK_RESULT, value);
> +
> +       if (value & SPMMC_SDSTATE_ERROR) {
> +               u32 timing_cfg0 = 0;
> +
> +               value = readl(host->base + SPMMC_SD_STATUS_REG);
> +
> +               if (host->tuning_info.enable_tuning) {
> +                       timing_cfg0 = readl(host->base + SPMMC_SD_TIMING_CONFIG0_REG);
> +                       host->tuning_info.rd_crc_dly = FIELD_GET(SPMMC_SD_READ_CRC_DELAY,
> +                                                                timing_cfg0);
> +                       host->tuning_info.rd_dat_dly = FIELD_GET(SPMMC_SD_READ_DATA_DELAY,
> +                                                                timing_cfg0);
> +                       host->tuning_info.rd_rsp_dly = FIELD_GET(SPMMC_SD_READ_RESPONSE_DELAY,
> +                                                                timing_cfg0);
> +                       host->tuning_info.wr_cmd_dly = FIELD_GET(SPMMC_SD_WRITE_COMMAND_DELAY,
> +                                                                timing_cfg0);
> +                       host->tuning_info.wr_dat_dly = FIELD_GET(SPMMC_SD_WRITE_DATA_DELAY,
> +                                                                timing_cfg0);
> +               }
> +
> +               if (value & SPMMC_SDSTATUS_RSP_TIMEOUT) {
> +                       ret = -ETIMEDOUT;
> +                       host->tuning_info.wr_cmd_dly++;
> +               } else if (value & SPMMC_SDSTATUS_RSP_CRC7_ERROR) {
> +                       ret = -EILSEQ;
> +                       host->tuning_info.rd_rsp_dly++;
> +               } else if (data) {
> +                       if ((value & SPMMC_SDSTATUS_STB_TIMEOUT)) {
> +                               ret = -ETIMEDOUT;
> +                               host->tuning_info.rd_dat_dly++;
> +                       } else if (value & SPMMC_SDSTATUS_RDATA_CRC16_ERROR) {
> +                               ret = -EILSEQ;
> +                               host->tuning_info.rd_dat_dly++;
> +                       } else if (value & SPMMC_SDSTATUS_CARD_CRC_CHECK_TIMEOUT) {
> +                               ret = -ETIMEDOUT;
> +                               host->tuning_info.rd_crc_dly++;
> +                       } else if (value & SPMMC_SDSTATUS_CRC_TOKEN_CHECK_ERROR) {
> +                               ret = -EILSEQ;
> +                               if (crc_token == 0x5)
> +                                       host->tuning_info.wr_dat_dly++;
> +                               else
> +                                       host->tuning_info.rd_crc_dly++;
> +                       }
> +               }
> +               cmd->error = ret;
> +               if (data) {
> +                       data->error = ret;
> +                       data->bytes_xfered = 0;
> +               }
> +               if (!host->tuning_info.need_tuning && host->tuning_info.enable_tuning)
> +                       cmd->retries = SPMMC_MAX_RETRIES;
> +               spmmc_sw_reset(host);
> +
> +               if (host->tuning_info.enable_tuning) {
> +                       timing_cfg0 |= FIELD_PREP(SPMMC_SD_READ_CRC_DELAY,
> +                                                      host->tuning_info.rd_crc_dly);
> +                       timing_cfg0 |= FIELD_PREP(SPMMC_SD_READ_DATA_DELAY,
> +                                                      host->tuning_info.rd_dat_dly);
> +                       timing_cfg0 |= FIELD_PREP(SPMMC_SD_READ_RESPONSE_DELAY,
> +                                                      host->tuning_info.rd_rsp_dly);
> +                       timing_cfg0 |= FIELD_PREP(SPMMC_SD_WRITE_COMMAND_DELAY,
> +                                                      host->tuning_info.wr_cmd_dly);
> +                       timing_cfg0 |= FIELD_PREP(SPMMC_SD_WRITE_DATA_DELAY,
> +                                                      host->tuning_info.wr_dat_dly);
> +                       writel(timing_cfg0, host->base + SPMMC_SD_TIMING_CONFIG0_REG);
> +               }
> +       } else if (data) {
> +               data->error = 0;
> +               data->bytes_xfered = data->blocks * data->blksz;
> +       }
> +       host->tuning_info.need_tuning = ret;
> +    /* controller will not send cmd 12 automatically if error occurred */

Is this comment really correct? It looks like the below code, ends up
sending a stop command no matter whether the request failed, no?

> +       if (cmd->opcode == MMC_READ_MULTIPLE_BLOCK ||
> +           cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK) {

Unless this is needed due to a specific HW-controller behaviour, I
would rather rely on that we check for "mrq->data->stop", as that
indicates (from the SD/eMMC specification point of view) whether we
need to send the stop command.

Moreover, in this way, we can avoid creating our own "mmc_command" in
spmmc_send_stop_cmd(), but can instead just use "mrq->data->stop".

> +               spmmc_send_stop_cmd(host);
> +               spmmc_sw_reset(host);
> +       }
> +
> +       return ret;
> +}

[...]

> +static void spmmc_set_power_mode(struct spmmc_host *host, struct mmc_ios *ios)
> +{
> +       if (host->power_state == ios->power_mode)
> +               return;
> +
> +       switch (ios->power_mode) {
> +               /* power off->up->on */
> +       case MMC_POWER_ON:
> +               spmmc_controller_init(host);
> +               break;
> +       case MMC_POWER_UP:
> +               break;
> +       case MMC_POWER_OFF:
> +               pm_runtime_put(host->mmc->parent);

This looks wrong to me. Unless you can explain more exactly what goes on here.

If there is an external regulator to power the card (the eMMC/SD/SDIO
card), that card should be power-controlled by calling
mmc_regulator_set_ocr() somewhere around in this function.

> +               break;
> +       }
> +       host->power_state = ios->power_mode;
> +}

[...]

> +
> +static int spmmc_drv_probe(struct platform_device *pdev)
> +{
> +       struct mmc_host *mmc;
> +       struct resource *res;
> +       struct spmmc_host *host;
> +       int ret = 0;
> +
> +       mmc = mmc_alloc_host(sizeof(*host), &pdev->dev);
> +       if (!mmc) {
> +               ret = -ENOMEM;
> +               goto probe_free_host;
> +       }
> +
> +       host = mmc_priv(mmc);
> +       host->mmc = mmc;
> +       host->power_state = MMC_POWER_UNDEFINED;
> +       host->dma_int_threshold = 1024;
> +       host->dmapio_mode = SPMMC_DMA_MODE;
> +
> +       host->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +       if (IS_ERR(host->base))
> +               return PTR_ERR(host->base);
> +
> +       host->clk = devm_clk_get(&pdev->dev, NULL);
> +       if (IS_ERR(host->clk))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(host->clk), "clk get fail\n");
> +
> +       host->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> +       if (IS_ERR(host->rstc))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(host->rstc), "rst get fail\n");
> +
> +       host->irq = platform_get_irq(pdev, 0);
> +       if (host->irq <= 0)
> +               return host->irq;
> +
> +       ret = devm_request_threaded_irq(&pdev->dev, host->irq,
> +                                       spmmc_irq, spmmc_func_finish_req, IRQF_SHARED,
> +                       NULL, host);
> +       if (ret)
> +               return ret;
> +
> +       ret = clk_prepare_enable(host->clk);
> +       if (ret)
> +               return dev_err_probe(&pdev->dev, ret, "failed to enable clk\n");
> +
> +       ret = mmc_of_parse(mmc);
> +       if (ret)
> +               goto probe_free_host;
> +
> +       spin_lock_init(&host->lock);
> +       mutex_init(&host->mrq_lock);
> +       mmc->ops = &spmmc_ops;
> +       mmc->f_min = SPMMC_MIN_CLK;
> +       if (mmc->f_max > SPMMC_MAX_CLK)
> +               mmc->f_max = SPMMC_MAX_CLK;
> +
> +       ret = mmc_regulator_get_supply(mmc);
> +       if (ret)
> +               goto probe_free_host;
> +
> +       if (!mmc->ocr_avail)
> +               mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
> +       mmc->max_seg_size = SPMMC_MAX_BLK_COUNT * 512;
> +       mmc->max_segs = SPMMC_MAX_DMA_MEMORY_SECTORS;
> +       mmc->max_req_size = SPMMC_MAX_BLK_COUNT * 512;
> +       mmc->max_blk_size = 512;
> +       mmc->max_blk_count = SPMMC_MAX_BLK_COUNT;
> +
> +       dev_set_drvdata(&pdev->dev, host);
> +       spmmc_controller_init(host);
> +       spmmc_set_sdmmc_mode(host);
> +       host->tuning_info.enable_tuning = 1;
> +       pm_runtime_set_active(&pdev->dev);
> +       pm_runtime_enable(&pdev->dev);
> +       mmc_add_host(mmc);
> +
> +       return ret;
> +
> +probe_free_host:
> +       if (mmc)
> +               mmc_free_host(mmc);
> +
> +       return ret;
> +}
> +
> +static int spmmc_drv_remove(struct platform_device *dev)
> +{
> +       struct spmmc_host *host = platform_get_drvdata(dev);
> +
> +       mmc_remove_host(host->mmc);
> +       clk_disable(host->clk);

This doesn't work, because there are no guarantees that the host is
runtime resumed at this point. Hence, the clock may be disabled
already.

To fix this, you should replace the above call to clk_disable() with a
call to pm_runtime_get_sync() instead.

> +       clk_disable_unprepare(host->clk);
> +       pm_runtime_disable(&dev->dev);

As you need to call pm_runtime_get_sync() above, you then need to
restore the runtime PM usage count here. So, add a call to
pm_runtime_put_noidle() here, that should do it.

> +       platform_set_drvdata(dev, NULL);
> +       mmc_free_host(host->mmc);
> +
> +       return 0;
> +}
> +
> +static int spmmc_pm_suspend(struct device *dev)
> +{
> +       pm_runtime_force_suspend(dev);
> +
> +       return 0;
> +}
> +
> +static int spmmc_pm_resume(struct device *dev)
> +{
> +       pm_runtime_force_resume(dev);
> +
> +       return 0;
> +}

Both spmmc_pm_suspend() and spmmc_pm_resume() can be entirely dropped,
see more below.

> +
> +static int spmmc_pm_runtime_suspend(struct device *dev)
> +{
> +       struct spmmc_host *host;
> +
> +       host = dev_get_drvdata(dev);
> +       clk_disable(host->clk);

You should replace the above call to clk_disable() with a call to
clk_disable_unprepare().

> +
> +       return 0;
> +}
> +
> +static int spmmc_pm_runtime_resume(struct device *dev)
> +{
> +       struct spmmc_host *host;
> +
> +       host = dev_get_drvdata(dev);
> +
> +       return clk_enable(host->clk);

You should replace the above call to clk_enable() with a call to
clk_prepare_enable().

> +}
> +
> +static const struct dev_pm_ops spmmc_pm_ops = {
> +       SYSTEM_SLEEP_PM_OPS(spmmc_pm_suspend, spmmc_pm_resume)
> +       RUNTIME_PM_OPS(spmmc_pm_runtime_suspend, spmmc_pm_runtime_resume, NULL)
> +};

The above can be replaced with:

static DEFINE_RUNTIME_DEV_PM_OPS(spmmc_pm_ops,
spmmc_pm_runtime_suspend, spmmc_pm_runtime_resume, NULL);

The system suspend/resume callback will then be set to
pm_runtime_force_suspend|resume(), which seems to be what you need.

> +
> +static const struct of_device_id spmmc_of_table[] = {
> +       {
> +               .compatible = "sunplus,sp7021-mmc",
> +       },
> +       {/* sentinel */}
> +};
> +MODULE_DEVICE_TABLE(of, spmmc_of_table);
> +
> +static struct platform_driver spmmc_driver = {
> +       .probe = spmmc_drv_probe,
> +       .remove = spmmc_drv_remove,
> +       .driver = {
> +               .name = "spmmc",
> +               .pm = pm_ptr(&spmmc_pm_ops),
> +               .of_match_table = spmmc_of_table,
> +       },
> +};
> +module_platform_driver(spmmc_driver);
> +
> +MODULE_AUTHOR("Tony Huang <tonyhuang.sunplus@gmail.com>");
> +MODULE_AUTHOR("Li-hao Kuo <lhjeff911@gmail.com>");
> +MODULE_DESCRIPTION("Sunplus MMC controller driver");
> +MODULE_LICENSE("GPL");

Kind regards
Uffe
