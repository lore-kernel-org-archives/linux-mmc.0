Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7893BC432BE
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Sep 2021 02:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A7AC600D0
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Sep 2021 02:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhIACzj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 31 Aug 2021 22:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbhIACzh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Aug 2021 22:55:37 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8240EC061575
        for <linux-mmc@vger.kernel.org>; Tue, 31 Aug 2021 19:54:41 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x16so923950pfh.2
        for <linux-mmc@vger.kernel.org>; Tue, 31 Aug 2021 19:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=blDVTraAcJdhYP4jti4hCSit/chK+H3lgItyHZl60Gs=;
        b=HREjKsAPR+4bH46J1QNtc0LAqkShRa/q+BPwGD3SmqaMWSh+LwTexs6kUtlAM1y4i5
         7zq2jZTpLhiMiMUke9fTbOkaOK0hCaKyPmFRXpw2NevFUqXSx7AzteHNMBSLng+I3Btj
         yJDLZZEUgSNkE86irvbLoQW8rDnoFr57bc3nbtaTokzmmCAfqP6i86KeWcu3FcMb/XBe
         jHpEoYvpY0267kh/+LWMxRENF/6EzPyELX1qQGmcmjp135oSrD15aZ6d/p9O8QiKKFat
         6poksw22AJXUAHy5qeAimDLeEip2ZndzaEvQbUkTmVEFAQZDUJf1oqqE3g2QH1SCkWSZ
         NBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=blDVTraAcJdhYP4jti4hCSit/chK+H3lgItyHZl60Gs=;
        b=KNkv/uo4CZs3oOPZkUF0ZZHqQoXdxmIKhS3NGJsS7jSF+xDT4ai+s3AyEvMVMz5BoI
         0OhEPv2nPNqDRts/jBjc7JJwIU5HXkebDQiERitLoTlJb1LQ/Z9VnjTEPKeamH8hE62N
         hBy3wj1LZjmDYOpq3gPusUlUq5owqgCk4ua7uoNQHV9e5jE9OzEi3/wDl1krAMscf5Bs
         fC7qamuL2sffq9jTj3zEDsrGKu1CbscQIoma0ijUlAKVeueHE8TVYxGZK+UvKVTsWCcI
         iQXt/QfB2CYdGG07CO1KdU6YpDEcokFQ4VsmG48vW7zYA3GiV6VzJysdVWnX6k+daujr
         Nw+A==
X-Gm-Message-State: AOAM533Mjm3Y64P2b7j7vvg01QBd7mIyxjyI0bNMwgNfWAMYPzXoNusm
        GTa1fLZ9Y6BvCWUOu/H6JX9ECw==
X-Google-Smtp-Source: ABdhPJzBwSB4kgNxmwZNvXDcNMcIBqCw5FWUrgaYVxBejN+6MyQ7cqHQMO91SEPFjviDO8SQLLF+NA==
X-Received: by 2002:a65:4147:: with SMTP id x7mr29309224pgp.23.1630464880741;
        Tue, 31 Aug 2021 19:54:40 -0700 (PDT)
Received: from laputa (p784a44f4.tkyea130.ap.so-net.ne.jp. [120.74.68.244])
        by smtp.gmail.com with ESMTPSA id s15sm14523843pfu.67.2021.08.31.19.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 19:54:39 -0700 (PDT)
Date:   Wed, 1 Sep 2021 11:54:35 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Jason Lai <jasonlai.genesyslogic@gmail.com>
Cc:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        Jason Lai <jason.lai@genesyslogic.com.tw>,
        linux-mmc@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw
Subject: Re: [PATCH 6/7] mmc: core: Implement content of UHS-II card
 initialization functions
Message-ID: <20210901025435.GA62506@laputa>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Jason Lai <jasonlai.genesyslogic@gmail.com>, ulf.hansson@linaro.org,
        adrian.hunter@intel.com, Jason Lai <jason.lai@genesyslogic.com.tw>,
        linux-mmc@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw
References: <20210831110227.50780-1-jasonlai.genesyslogic@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831110227.50780-1-jasonlai.genesyslogic@gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Jaison,

Thank you for continuing to work on UHS-II stuff.

On Tue, Aug 31, 2021 at 07:02:27PM +0800, Jason Lai wrote:
> From: Jason Lai <jason.lai@genesyslogic.com.tw>
> 
> From: Jason Lai <jason.lai@genesyslogic.com.tw>
> 
> UHS-II card initialization flow is divided into 2 categories: PHY & Card.
> Part 1 - PHY Initialization:
>          Every host controller may need their own avtivation operation
>          to establish LINK between controller and card. So we add a new
>          member function(uhs2_detect_init) in struct mmc_host_ops for host
>          controller use.
> Part 2 - Card Initialization:
>          This part can be divided into 6 substeps.
>          1. Send UHS-II CCMD DEVICE_INIT to card.
>          2. Send UHS-II CCMD ENUMERATE to card.
>          3. Send UHS-II Native Read CCMD to obtain capabilities in CFG_REG
>             of card.
>          4. Host compares capabilities of host controller and  card,
> 	    then write the negotiated values to Setting field in CFG_REG
>             of card through UHS-II Native Write CCMD.
>          5. Switch host controller's clock to Range B if it is supported
> 	    by both host controller and card.
>          6. Execute legacy SD initialization flow.
> 
> Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
> ---
>  drivers/mmc/core/sd_uhs2.c | 918 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 868 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
> index 24aa51a6d..d9ceee20d 100644
> --- a/drivers/mmc/core/sd_uhs2.c
> +++ b/drivers/mmc/core/sd_uhs2.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2021 Linaro Ltd
>   *
>   * Author: Ulf Hansson <ulf.hansson@linaro.org>
> + * Author: Jason Lai <jason.lai@genesyslogic.com.tw>

Just one comment:
I think that most of the code added here still came from Intel's
original patch[1]. So you should give them credit for their contribution.

-Takahiro Akashi

[1] https://lore.kernel.org/linux-mmc/1419672479-30852-2-git-send-email-yi.y.sun@intel.com/


>   *
>   * Support for SD UHS-II cards
>   */
> @@ -10,29 +11,37 @@
>  
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/card.h>
> +#include <linux/mmc/sd_uhs2.h>
>  
>  #include "core.h"
>  #include "bus.h"
>  #include "sd.h"
>  #include "mmc_ops.h"
> +#include "sd_uhs2.h"
>  
>  static const unsigned int sd_uhs2_freqs[] = { 52000000, 26000000 };
>  
> -static int sd_uhs2_set_ios(struct mmc_host *host)
> +static void sd_uhs2_set_ios(struct mmc_host *host)
>  {
>  	struct mmc_ios *ios = &host->ios;
>  
> -	return host->ops->uhs2_set_ios(host, ios);
> +	pr_debug("%s: clock=%uHz, bus_mode=%u, power_mode=%u, ",
> +		 mmc_hostname(host), ios->clock, ios->bus_mode,
> +		 ios->power_mode);
> +	pr_debug("cs=%u, Vdd=%u, width=%u, timing=%u\n",
> +		 ios->chip_select, ios->vdd, 1 << ios->bus_width,
> +		 ios->timing);
> +
> +	host->ops->uhs2_set_ios(host, ios);
>  }
>  
> -static int sd_uhs2_power_up(struct mmc_host *host)
> +static void sd_uhs2_power_up(struct mmc_host *host)
>  {
>  	host->ios.vdd = fls(host->ocr_avail) - 1;
>  	host->ios.clock = host->f_init;
>  	host->ios.timing = MMC_TIMING_SD_UHS2;
>  	host->ios.power_mode = MMC_POWER_UP;
>  
> -	return sd_uhs2_set_ios(host);
> +	sd_uhs2_set_ios(host);
>  }
>  
>  static void sd_uhs2_power_off(struct mmc_host *host)
> @@ -45,6 +54,43 @@ static void sd_uhs2_power_off(struct mmc_host *host)
>  	sd_uhs2_set_ios(host);
>  }
>  
> +/*
> + * uhs2_cmd_assemble - assemble and build up uhs2 command
> + * @cmd:	MMC command
> + * @uhs2_cmd:	UHS2 command
> + * @header:	Value of packet header
> + * @arg:	Argument of packet
> + * @payload:	Payload of packet
> + * @plen:	Payload length
> + * @resp:	Buffer for response
> + * @resp_len:	Response buffer length
> + *
> + * resp is inputted outside which should be a variable created by caller
> + * so caller should handle it. For SD command, there is no uhs2_resp and
> + * response should be stored in resp of mmc_command.
> + */
> +static void uhs2_cmd_assemble(struct mmc_command *cmd,
> +			      struct uhs2_command *uhs2_cmd,
> +			      u16 header, u16 arg,
> +			      u32 *payload, u8 plen, u8 *resp, u8 resp_len)
> +{
> +	uhs2_cmd->header = header;
> +	uhs2_cmd->arg = arg;
> +	uhs2_cmd->payload = payload;
> +	uhs2_cmd->payload_len = plen * sizeof(u32);
> +	uhs2_cmd->packet_len = uhs2_cmd->payload_len + 4;
> +
> +	cmd->uhs2_cmd = uhs2_cmd;
> +	cmd->uhs2_resp = resp;
> +	cmd->uhs2_resp_len = resp_len;
> +
> +	pr_debug("%s: uhs2_cmd: header=0x%x arg=0x%x\n",
> +		 __func__, uhs2_cmd->header, uhs2_cmd->arg);
> +	pr_debug("%s:           payload_len=%d packet_len=%d resp_len=%d\n",
> +		 __func__, uhs2_cmd->payload_len, uhs2_cmd->packet_len,
> +		 cmd->uhs2_resp_len);
> +}
> +
>  /*
>   * Run the phy initialization sequence, which mainly relies on the UHS-II host
>   * to check that we reach the expected electrical state, between the host and
> @@ -52,16 +98,104 @@ static void sd_uhs2_power_off(struct mmc_host *host)
>   */
>  static int sd_uhs2_phy_init(struct mmc_host *host)
>  {
> +	int err = 0;
> +
> +	/*
> +	 * Every host controller can assign its own function which is used
> +	 * to initialize PHY.
> +	 */
> +	if (host->ops->uhs2_detect_init) {
> +		err = host->ops->uhs2_detect_init(host)
> +		if (err) {
> +			pr_err("%s: fail to detect UHS2!\n",
> +			       mmc_hostname(host));
> +			err = UHS2_PHY_INIT_ERR;
> +		}
> +	}
> +
>  	return 0;
>  }
>  
>  /*
>   * Do the early initialization of the card, by sending the device init
> -roadcast
> - * command and wait for the process to be completed.
> + * broadcast command and wait for the process to be completed.
>   */
>  static int sd_uhs2_dev_init(struct mmc_host *host)
>  {
> +	struct mmc_command cmd = {0};
> +	struct uhs2_command uhs2_cmd = {};
> +	u32 cnt;
> +	u32 dap, gap, gap1;
> +	u16 header = 0, arg = 0;
> +	u32 payload[1];
> +	u8 plen = 1;
> +	u8 gd = 0, cf = 1;
> +	u8 resp[6] = {0};
> +	u8 resp_len = 6;
> +	int err;
> +
> +	dap = host->uhs2_caps.dap;
> +	gap = host->uhs2_caps.gap;
> +
> +	header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD;
> +	arg = ((UHS2_DEV_CMD_DEVICE_INIT & 0xFF) << 8) |
> +		UHS2_NATIVE_CMD_WRITE |
> +		UHS2_NATIVE_CMD_PLEN_4B |
> +		(UHS2_DEV_CMD_DEVICE_INIT >> 8);
> +
> +	/* need this for some cards */
> +	cmd.busy_timeout = 1000;
> +
> +	for (cnt = 0; cnt < 30; cnt++) {
> +		payload[0] = ((dap & 0xF) << 12) |
> +			(cf << 11)         |
> +			((gd & 0xF) << 4)  |
> +			(gap & 0xF);
> +
> +		uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg,
> +				  payload, plen, resp, resp_len);
> +
> +		DBG("Begin DEVICE_INIT, header=0x%x, arg=0x%x, payload=0x%x.\n",
> +		    header, arg, payload[0]);
> +
> +		DBG("Sending DEVICE_INIT. Count = %d\n", cnt);
> +		err = mmc_wait_for_cmd(host, &cmd, 0);
> +
> +		if (err) {
> +			pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> +			       mmc_hostname(host), __func__, err);
> +			return -EIO;
> +		}
> +
> +		if (IS_ENABLED(CONFIG_MMC_DEBUG)) {
> +			int i;
> +
> +			pr_warn("%s: DEVICE_INIT response is: ",
> +				mmc_hostname(host));
> +			for (i = 0; i < resp_len; i++)
> +				pr_warn("0x%x ", resp[i]);
> +			pr_warn("\n");
> +		}
> +
> +		if (resp[3] != (UHS2_DEV_CMD_DEVICE_INIT & 0xFF)) {
> +			pr_err("%s: DEVICE_INIT response is wrong!\n",
> +			       mmc_hostname(host));
> +			return -EIO;
> +		}
> +
> +		if (resp[5] & 0x8) {
> +			DBG("CF is set, device is initialized!\n");
> +			host->group_desc = gd;
> +			break;
> +		}
> +		gap1 = resp[4] & 0x0F;
> +		if (gap == gap1)
> +			gd++;
> +	}
> +	if (cnt == 30) {
> +		pr_err("%s: DEVICE_INIT fail, already 30 times!\n",
> +		       mmc_hostname(host));
> +		return -EIO;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -70,8 +204,60 @@ static int sd_uhs2_dev_init(struct mmc_host *host)
>   * Note that, we currently support only the point to point connection, which
>   * means only one card can be attached per host/slot.
>   */
> -static int sd_uhs2_enum(struct mmc_host *host, u32 *node_id)
> +static int sd_uhs2_enum(struct mmc_host *host)
>  {
> +	struct mmc_command cmd = {0};
> +	struct uhs2_command uhs2_cmd = {};
> +	u16 header = 0, arg = 0;
> +	u32 payload[1];
> +	u8 plen = 1;
> +	u8 id_f = 0xF, id_l = 0x0;
> +	u8 resp[8] = {0};
> +	u8 resp_len = 8;
> +	int err;
> +
> +	header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD;
> +	arg = ((UHS2_DEV_CMD_ENUMERATE & 0xFF) << 8) |
> +		UHS2_NATIVE_CMD_WRITE |
> +		UHS2_NATIVE_CMD_PLEN_4B |
> +		(UHS2_DEV_CMD_ENUMERATE >> 8);
> +
> +	payload[0] = (id_f << 4) | id_l;
> +
> +	DBG("Begin ENUMERATE, header=0x%x, arg=0x%x, payload=0x%x.\n",
> +	    header, arg, payload[0]);
> +	uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, plen,
> +			  resp, resp_len);
> +
> +	err = mmc_wait_for_cmd(host, &cmd, 0);
> +	if (err) {
> +		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> +		       mmc_hostname(host), __func__, err);
> +		return -EIO;
> +	}
> +
> +	if (IS_ENABLED(CONFIG_MMC_DEBUG)) {
> +		int i;
> +
> +		pr_warn("%s: ENUMERATE response is: ", mmc_hostname(host));
> +		for (i = 0; i < resp_len; i++)
> +			pr_warn("0x%x ", resp[i]);
> +		pr_warn("\n");
> +	}
> +
> +	if (resp[3] != (UHS2_DEV_CMD_ENUMERATE & 0xFF)) {
> +		pr_err("%s: ENUMERATE response is wrong!\n",
> +		       mmc_hostname(host));
> +		return -EIO;
> +	}
> +
> +	id_f = (resp[4] >> 4) & 0xF;
> +	id_l = resp[4] & 0xF;
> +	DBG("id_f = %d, id_l = %d.\n", id_f, id_l);
> +	DBG("Enumerate Cmd Completed. No. of Devices connected = %d\n",
> +	    id_l - id_f + 1);
> +	host->uhs2_dev_prop.node_id = id_f;
> +
>  	return 0;
>  }
>  
> @@ -80,8 +266,158 @@ static int sd_uhs2_enum(struct mmc_host *host, u32 *node_id)
>   * commands and by parsing the responses. Store a copy of the relevant data in
>   * card->uhs2_config.
>   */
> -static int sd_uhs2_config_read(struct mmc_host *host, struct mmc_card *card)
> +static int sd_uhs2_config_read(struct mmc_host *host)
>  {
> +	struct mmc_command cmd = {0};
> +	struct uhs2_command uhs2_cmd = {};
> +	u16 header = 0, arg = 0;
> +	u32 cap;
> +	int err;
> +
> +	DBG("INQUIRY_CFG: read Generic Caps.\n");
> +	header = UHS2_NATIVE_PACKET |
> +		 UHS2_PACKET_TYPE_CCMD |
> +		 host->uhs2_dev_prop.node_id;
> +	arg = ((UHS2_DEV_CONFIG_GEN_CAPS & 0xFF) << 8) |
> +		UHS2_NATIVE_CMD_READ |
> +		UHS2_NATIVE_CMD_PLEN_4B |
> +		(UHS2_DEV_CONFIG_GEN_CAPS >> 8);
> +
> +	pr_debug("Begin INQUIRY_CFG, header=0x%x, arg=0x%x.\n", header, arg);
> +	/* There is no payload because per spec, there should be
> +	 * no payload field for read CCMD.
> +	 * Plen is set in arg. Per spec, plen for read CCMD
> +	 * represents the len of read data which is assigned in payload
> +	 * of following RES (p136).
> +	 */
> +	uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, NULL, 0, NULL, 0);
> +
> +	err = mmc_wait_for_cmd(host, &cmd, 0);
> +	if (err) {
> +		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> +		       mmc_hostname(host), __func__, err);
> +		return -EIO;
> +	}
> +
> +	if (IS_ENABLED(CONFIG_MMC_DEBUG)) {
> +		int i;
> +
> +		pr_warn("%s: INQUIRY_CFG generic response is: ",
> +			mmc_hostname(host));
> +		for (i = 0; i < 2; i++)
> +			pr_warn("0x%x ", cmd.resp[i]);
> +		pr_warn("\n");
> +	}
> +
> +	cap = cmd.resp[0];
> +	pr_debug("Device Generic Caps (0-31) is: 0x%x.\n", cap);
> +	host->uhs2_dev_prop.n_lanes = (cap >> UHS2_DEV_CONFIG_N_LANES_POS) &
> +					UHS2_DEV_CONFIG_N_LANES_MASK;
> +	host->uhs2_dev_prop.dadr_len = (cap >> UHS2_DEV_CONFIG_DADR_POS) &
> +					UHS2_DEV_CONFIG_DADR_MASK;
> +	host->uhs2_dev_prop.app_type = (cap >> UHS2_DEV_CONFIG_APP_POS) &
> +					UHS2_DEV_CONFIG_APP_MASK;
> +
> +	pr_debug("INQUIRY_CFG: read PHY Caps.\n");
> +	arg = ((UHS2_DEV_CONFIG_PHY_CAPS & 0xFF) << 8) |
> +		UHS2_NATIVE_CMD_READ |
> +		UHS2_NATIVE_CMD_PLEN_8B |
> +		(UHS2_DEV_CONFIG_PHY_CAPS >> 8);
> +
> +	pr_debug("Begin INQUIRY_CFG, header=0x%x, arg=0x%x.\n", header, arg);
> +	uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, NULL, 0, NULL, 0);
> +
> +	err = mmc_wait_for_cmd(host, &cmd, 0);
> +	if (err) {
> +		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> +		       mmc_hostname(host), __func__, err);
> +		return -EIO;
> +	}
> +
> +	if (IS_ENABLED(CONFIG_MMC_DEBUG)) {
> +		int i;
> +
> +		pr_warn("%s: INQUIRY_CFG PHY response is: ",
> +			mmc_hostname(host));
> +		for (i = 0; i < 2; i++)
> +			pr_warn("0x%x ", cmd.resp[i]);
> +		pr_warn("\n");
> +	}
> +
> +	cap = cmd.resp[0];
> +	pr_debug("Device PHY Caps (0-31) is: 0x%x.\n", cap);
> +	host->uhs2_dev_prop.phy_minor_rev = cap &
> +					UHS2_DEV_CONFIG_PHY_MINOR_MASK;
> +	host->uhs2_dev_prop.phy_major_rev = (cap >>
> +					UHS2_DEV_CONFIG_PHY_MAJOR_POS) &
> +					UHS2_DEV_CONFIG_PHY_MAJOR_MASK;
> +	host->uhs2_dev_prop.can_hibernate = (cap >>
> +					UHS2_DEV_CONFIG_CAN_HIBER_POS) &
> +					UHS2_DEV_CONFIG_CAN_HIBER_MASK;
> +
> +	cap = cmd.resp[1];
> +	pr_debug("Device PHY Caps (32-63) is: 0x%x.\n", cap);
> +	host->uhs2_dev_prop.n_lss_sync = cap & UHS2_DEV_CONFIG_N_LSS_SYN_MASK;
> +	host->uhs2_dev_prop.n_lss_dir = (cap >>
> +					UHS2_DEV_CONFIG_N_LSS_DIR_POS) &
> +					UHS2_DEV_CONFIG_N_LSS_DIR_MASK;
> +	if (host->uhs2_dev_prop.n_lss_sync == 0)
> +		host->uhs2_dev_prop.n_lss_sync = 16 << 2;
> +	else
> +		host->uhs2_dev_prop.n_lss_sync <<= 2;
> +
> +	if (host->uhs2_dev_prop.n_lss_dir == 0)
> +		host->uhs2_dev_prop.n_lss_dir = 16 << 3;
> +	else
> +		host->uhs2_dev_prop.n_lss_dir <<= 3;
> +
> +	pr_debug("INQUIRY_CFG: read LINK-TRAN Caps.\n");
> +	arg = ((UHS2_DEV_CONFIG_LINK_TRAN_CAPS & 0xFF) << 8) |
> +		UHS2_NATIVE_CMD_READ |
> +		UHS2_NATIVE_CMD_PLEN_8B |
> +		(UHS2_DEV_CONFIG_LINK_TRAN_CAPS >> 8);
> +
> +	pr_debug("Begin INQUIRY_CFG, header=0x%x, arg=0x%x.\n", header, arg);
> +	uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, NULL, 0, NULL, 0);
> +
> +	err = mmc_wait_for_cmd(host, &cmd, 0);
> +	if (err) {
> +		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> +		       mmc_hostname(host), __func__, err);
> +		return -EIO;
> +	}
> +
> +	if (IS_ENABLED(CONFIG_MMC_DEBUG)) {
> +		int i;
> +
> +		pr_warn("%s: INQUIRY_CFG Link-Tran response is: ",
> +			mmc_hostname(host));
> +		for (i = 0; i < 2; i++)
> +			pr_warn("0x%x ", cmd.resp[i]);
> +		pr_warn("\n");
> +	}
> +
> +	cap = cmd.resp[0];
> +	DBG("Device LINK-TRAN Caps (0-31) is: 0x%x.\n", cap);
> +	host->uhs2_dev_prop.link_minor_rev = cap &
> +					UHS2_DEV_CONFIG_LT_MINOR_MASK;
> +	host->uhs2_dev_prop.link_major_rev = (cap >>
> +					UHS2_DEV_CONFIG_LT_MAJOR_POS) &
> +					UHS2_DEV_CONFIG_LT_MAJOR_MASK;
> +	host->uhs2_dev_prop.n_fcu = (cap >> UHS2_DEV_CONFIG_N_FCU_POS) &
> +					UHS2_DEV_CONFIG_N_FCU_MASK;
> +	host->uhs2_dev_prop.dev_type = (cap >> UHS2_DEV_CONFIG_DEV_TYPE_POS) &
> +					UHS2_DEV_CONFIG_DEV_TYPE_MASK;
> +	host->uhs2_dev_prop.maxblk_len = (cap >>
> +					UHS2_DEV_CONFIG_MAX_BLK_LEN_POS) &
> +					UHS2_DEV_CONFIG_MAX_BLK_LEN_MASK;
> +
> +	cap = cmd.resp[1];
> +	DBG("Device LINK-TRAN Caps (32-63) is: 0x%x.\n", cap);
> +	host->uhs2_dev_prop.n_data_gap = cap & UHS2_DEV_CONFIG_N_DATA_GAP_MASK;
> +	if (host->uhs2_dev_prop.n_fcu == 0)
> +		host->uhs2_dev_prop.n_fcu = 256;
> +
>  	return 0;
>  }
>  
> @@ -89,15 +425,393 @@ static int sd_uhs2_config_read(struct mmc_host *host, struct mmc_card *card)
>   * Based on the card's and host's UHS-II capabilities, let's update the
>   * configuration of the card and the host. This may also include to move to a
>   * greater speed range/mode. Depending on the updated configuration, we may
> -eed
> - * to do a soft reset of the card via sending it a GO_DORMANT_STATE command.
> + * need to do a soft reset of the card via sending it a GO_DORMANT_STATE command.
>   *
> - * In the final step, let's check if the card signals "config completion",
> -hich
> - * indicates that the card has moved from config state into active state.
> + * In the final step, let's check if the card signals "config completion",
> + * which indicates that the card has moved from config state into active state.
>   */
> -static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
> +static int sd_uhs2_config_write(struct mmc_host *host)
> +{
> +	struct mmc_command cmd = {0};
> +	struct uhs2_command uhs2_cmd = {};
> +	u16 header = 0, arg = 0;
> +	u32 payload[2];
> +	u8 nMinDataGap;
> +	u8 plen;
> +	u8 try;
> +	int err;
> +	u8 resp[5] = {0};
> +	u8 resp_len = 5;
> +
> +	pr_debug("SET_COMMON_CFG: write Generic Settings.\n");
> +	header = UHS2_NATIVE_PACKET |
> +		 UHS2_PACKET_TYPE_CCMD | host->uhs2_dev_prop.node_id;
> +	arg = ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
> +		UHS2_NATIVE_CMD_WRITE |
> +		UHS2_NATIVE_CMD_PLEN_8B |
> +		(UHS2_DEV_CONFIG_GEN_SET >> 8);
> +
> +	if (host->uhs2_dev_prop.n_lanes == UHS2_DEV_CONFIG_2L_HD_FD &&
> +	    host->uhs2_caps.n_lanes == UHS2_DEV_CONFIG_2L_HD_FD) {
> +		/* Support HD */
> +		pr_debug("Both Host and device support 2L-HD.\n");
> +		host->flags |= MMC_UHS2_2L_HD;
> +		host->uhs2_caps.n_lanes_set = UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
> +		host->uhs2_dev_prop.n_lanes_set =
> +				UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
> +		nMinDataGap = 1;
> +	} else {
> +		/* Only support 2L-FD so far */
> +		host->flags &= ~MMC_UHS2_2L_HD;
> +		host->uhs2_caps.n_lanes_set = UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
> +		host->uhs2_dev_prop.n_lanes_set =
> +				UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
> +		nMinDataGap = 3;
> +	}
> +
> +	plen = 2;
> +	payload[0] = host->uhs2_dev_prop.n_lanes_set <<
> +		     UHS2_DEV_CONFIG_N_LANES_POS;
> +	payload[1] = 0;
> +	payload[0] = cpu_to_be32(payload[0]);
> +	payload[1] = cpu_to_be32(payload[1]);
> +
> +	pr_debug("Begin SET_COMMON_CFG, header=0x%x, arg=0x%x\n", header, arg);
> +	pr_debug("UHS2 write Generic Settings %08x %08x\n",
> +		 payload[0], payload[1]);
> +	pr_debug("flags=%08x, ", host->flags);
> +	pr_debug("host_caps.n_lanes_set%x, ", host->uhs2_caps.n_lanes_set);
> +	pr_debug("dev_prop.n_lanes_set=%x\n", host->uhs2_dev_prop.n_lanes_set);
> +
> +	/*
> +	 * There is no payload because per spec, there should be
> +	 * no payload field for read CCMD.
> +	 * Plen is set in arg. Per spec, plen for read CCMD
> +	 * represents the len of read data which is assigned in payload
> +	 * of following RES (p136).
> +	 */
> +	uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, plen, NULL, 0);
> +
> +	err = mmc_wait_for_cmd(host, &cmd, 0);
> +	if (err) {
> +		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> +		       mmc_hostname(host), __func__, err);
> +		return -EIO;
> +	}
> +
> +	pr_debug("SET_COMMON_CFG: PHY Settings.\n");
> +	arg = ((UHS2_DEV_CONFIG_PHY_SET & 0xFF) << 8) |
> +		UHS2_NATIVE_CMD_WRITE |
> +		UHS2_NATIVE_CMD_PLEN_8B |
> +		(UHS2_DEV_CONFIG_PHY_SET >> 8);
> +
> +	for (try = 0; try < 2; try++) {
> +		plen = 2;
> +
> +		if (host->uhs2_caps.speed_range ==
> +			UHS2_DEV_CONFIG_PHY_SET_SPEED_B) {
> +			host->flags |= MMC_UHS2_SPEED_B;
> +			host->uhs2_dev_prop.speed_range_set =
> +				UHS2_DEV_CONFIG_PHY_SET_SPEED_B;
> +			pr_debug("set dev_prop.speed_range_set to SPEED_B\n");
> +		} else {
> +			host->uhs2_dev_prop.speed_range_set =
> +				UHS2_DEV_CONFIG_PHY_SET_SPEED_A;
> +			host->flags &= ~MMC_UHS2_SPEED_B;
> +			pr_debug("set dev_prop.speed_range_set to SPEED_A\n");
> +		}
> +
> +		payload[0] = host->uhs2_dev_prop.speed_range_set <<
> +				UHS2_DEV_CONFIG_PHY_SET_SPEED_POS;
> +
> +		host->uhs2_dev_prop.n_lss_sync_set =
> +			(min(host->uhs2_dev_prop.n_lss_sync,
> +			host->uhs2_caps.n_lss_sync) >> 2) &
> +			UHS2_DEV_CONFIG_N_LSS_SYN_MASK;
> +		host->uhs2_caps.n_lss_sync_set =
> +			host->uhs2_dev_prop.n_lss_sync_set;
> +
> +		if (try == 0) {
> +			host->uhs2_caps.n_lss_dir_set =
> +				(host->uhs2_dev_prop.n_lss_dir >> 3) &
> +				UHS2_DEV_CONFIG_N_LSS_DIR_MASK;
> +			host->uhs2_dev_prop.n_lss_dir_set =
> +				((host->uhs2_caps.n_lss_dir >> 3) + 1) &
> +				UHS2_DEV_CONFIG_N_LSS_DIR_MASK;
> +		} else {
> +			host->uhs2_dev_prop.n_lss_dir_set =
> +				(max(host->uhs2_dev_prop.n_lss_dir,
> +				host->uhs2_caps.n_lss_dir) >> 3) &
> +				UHS2_DEV_CONFIG_N_LSS_DIR_MASK;
> +			host->uhs2_caps.n_lss_dir_set =
> +				host->uhs2_dev_prop.n_lss_dir_set;
> +			payload[1] = (host->uhs2_dev_prop.n_lss_dir_set <<
> +				UHS2_DEV_CONFIG_N_LSS_DIR_POS) |
> +				host->uhs2_dev_prop.n_lss_sync_set;
> +		}
> +
> +		payload[1] = (host->uhs2_dev_prop.n_lss_dir_set <<
> +				UHS2_DEV_CONFIG_N_LSS_DIR_POS) |
> +				host->uhs2_dev_prop.n_lss_sync_set;
> +		payload[0] = cpu_to_be32(payload[0]);
> +		payload[1] = cpu_to_be32(payload[1]);
> +
> +		pr_debug("UHS2 SET PHY Settings  %08x %08x\n",
> +			 payload[0], payload[1]);
> +		pr_debug("host->flags=%08x dev_prop.speed_range_set=%x\n",
> +			 host->flags,
> +			 host->uhs2_dev_prop.speed_range_set);
> +		pr_debug("dev_prop.n_lss_sync_set=%x host_caps.n_lss_sync_set=%x\n",
> +			 host->uhs2_dev_prop.n_lss_sync_set,
> +			 host->uhs2_caps.n_lss_sync_set);
> +		pr_debug("dev_prop.n_lss_dir_set=%x host_caps.n_lss_dir_set=%x\n",
> +			 host->uhs2_dev_prop.n_lss_dir_set,
> +			 host->uhs2_caps.n_lss_dir_set);
> +
> +		pr_debug("Begin SET_COMMON_CFG header=0x%x arg=0x%x\n",
> +			 header, arg);
> +		pr_debug("\t\tpayload[0]=0x%x payload[1]=0x%x\n",
> +			 payload[0], payload[1]);
> +
> +		resp_len = 4;
> +		memset(resp, 0, sizeof(resp));
> +
> +		uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg,
> +				  payload, plen, resp, resp_len);
> +
> +		err = mmc_wait_for_cmd(host, &cmd, 0);
> +		if (err) {
> +			pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> +			       mmc_hostname(host), __func__, err);
> +			return -EIO;
> +		}
> +
> +		if (!(resp[2] & 0x80))
> +			break;
> +
> +		pr_debug("%s: %s: UHS2 SET PHY Settings fail, res= 0x%x!\n",
> +			 mmc_hostname(host), __func__,  resp[2]);
> +	}
> +
> +	pr_debug("SET_COMMON_CFG: LINK-TRAN Settings.\n");
> +	arg = ((UHS2_DEV_CONFIG_LINK_TRAN_SET & 0xFF) << 8) |
> +		UHS2_NATIVE_CMD_WRITE |
> +		UHS2_NATIVE_CMD_PLEN_8B |
> +		(UHS2_DEV_CONFIG_LINK_TRAN_SET >> 8);
> +
> +	plen = 2;
> +
> +	if (host->uhs2_dev_prop.app_type == UHS2_DEV_CONFIG_APP_SD_MEM)
> +		host->uhs2_dev_prop.maxblk_len_set =
> +			UHS2_DEV_CONFIG_LT_SET_MAX_BLK_LEN;
> +	else
> +		host->uhs2_dev_prop.maxblk_len_set =
> +			min(host->uhs2_dev_prop.maxblk_len,
> +			    host->uhs2_caps.maxblk_len);
> +	host->uhs2_caps.maxblk_len_set = host->uhs2_dev_prop.maxblk_len_set;
> +
> +	host->uhs2_dev_prop.n_fcu_set =
> +		min(host->uhs2_dev_prop.n_fcu,
> +		    host->uhs2_caps.n_fcu);
> +	host->uhs2_caps.n_fcu_set = host->uhs2_dev_prop.n_fcu_set;
> +
> +	host->uhs2_dev_prop.n_data_gap_set =
> +		max(nMinDataGap, host->uhs2_dev_prop.n_data_gap);
> +
> +	host->uhs2_caps.n_data_gap_set = host->uhs2_dev_prop.n_data_gap_set;
> +
> +	host->uhs2_caps.max_retry_set = 3;
> +	host->uhs2_dev_prop.max_retry_set = host->uhs2_caps.max_retry_set;
> +
> +	payload[0] = (host->uhs2_dev_prop.maxblk_len_set <<
> +			UHS2_DEV_CONFIG_MAX_BLK_LEN_POS) |
> +			(host->uhs2_dev_prop.max_retry_set <<
> +			UHS2_DEV_CONFIG_LT_SET_MAX_RETRY_POS) |
> +			(host->uhs2_dev_prop.n_fcu_set <<
> +			UHS2_DEV_CONFIG_N_FCU_POS);
> +	payload[1] = host->uhs2_dev_prop.n_data_gap_set;
> +	payload[0] = cpu_to_be32(payload[0]);
> +	payload[1] = cpu_to_be32(payload[1]);
> +
> +	pr_debug("Begin SET_COMMON_CFG header=0x%x arg=0x%x\n", header, arg);
> +	pr_debug("\t\tpayload[0]=0x%x payload[1]=0x%x\n",
> +		 payload[0], payload[1]);
> +
> +	uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, plen, NULL, 0);
> +
> +	err = mmc_wait_for_cmd(host, &cmd, 0);
> +	if (err) {
> +		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> +		       mmc_hostname(host), __func__, err);
> +		return -EIO;
> +	}
> +
> +	pr_debug("SET_COMMON_CFG: Set Config Completion.\n");
> +	arg = ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
> +		UHS2_NATIVE_CMD_WRITE |
> +		UHS2_NATIVE_CMD_PLEN_8B |
> +		(UHS2_DEV_CONFIG_GEN_SET >> 8);
> +
> +	plen = 2;
> +	payload[0] = 0;
> +	payload[1] = UHS2_DEV_CONFIG_GEN_SET_CFG_COMPLETE;
> +	payload[0] = cpu_to_be32(payload[0]);
> +	payload[1] = cpu_to_be32(payload[1]);
> +
> +	pr_debug("Begin SET_COMMON_CFG, ");
> +	pr_debug("header=0x%x, arg=0x%x, payload[0] = 0x%x.\n",
> +		 header, arg, payload[0]);
> +	resp_len = 5;
> +	memset(resp, 0, sizeof(resp));
> +	uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, plen,
> +			  resp, resp_len);
> +
> +	err = mmc_wait_for_cmd(host, &cmd, 0);
> +	if (err) {
> +		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> +		       mmc_hostname(host), __func__, err);
> +		return -EIO;
> +	}
> +
> +	/* Set host Config Setting registers */
> +	if (!host->ops->uhs2_set_reg ||
> +	    host->ops->uhs2_set_reg(host, SET_CONFIG)) {
> +		pr_err("%s: %s: UHS2 SET_CONFIG fail!\n",
> +		       mmc_hostname(host), __func__);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int uhs2_go_dormant(struct mmc_host *host, bool hibernate)
>  {
> +	struct mmc_command cmd = {0};
> +	struct uhs2_command uhs2_cmd = {};
> +	u16 header = 0, arg = 0;
> +	u32 payload[1];
> +	u8 plen = 1;
> +	int err;
> +
> +	/* Disable Normal INT */
> +	if (!host->ops->uhs2_set_reg ||
> +	    host->ops->uhs2_set_reg(host, DISABLE_INT)) {
> +		pr_err("%s: %s: UHS2 DISABLE_INT fail!\n",
> +		       mmc_hostname(host), __func__);
> +		return -EIO;
> +	}
> +
> +	header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD |
> +		host->uhs2_dev_prop.node_id;
> +
> +	arg = ((UHS2_DEV_CMD_GO_DORMANT_STATE & 0xFF) << 8) |
> +		UHS2_NATIVE_CMD_WRITE |
> +		UHS2_NATIVE_CMD_PLEN_4B |
> +		(UHS2_DEV_CMD_GO_DORMANT_STATE >> 8);
> +
> +	if (hibernate)
> +		payload[0] = UHS2_DEV_CMD_DORMANT_HIBER;
> +
> +	pr_debug("Begin GO_DORMANT_STATE, ");
> +	pr_debug("header=0x%x, arg=0x%x, payload=0x%x.\n",
> +		 header, arg, payload[0]);
> +	uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, plen, NULL, 0);
> +
> +	err = mmc_wait_for_cmd(host, &cmd, 0);
> +	if (err) {
> +		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> +		       mmc_hostname(host), __func__, err);
> +		return -EIO;
> +	}
> +
> +	/* Check Dormant State in Present */
> +	if (!host->ops->uhs2_set_reg ||
> +	    host->ops->uhs2_set_reg(host, CHECK_DORMANT)) {
> +		pr_err("%s: %s: UHS2 GO_DORMANT_STATE fail!\n",
> +		       mmc_hostname(host), __func__);
> +		return -EIO;
> +	}
> +
> +	if (host->ops->uhs2_disable_clk)
> +		host->ops->uhs2_disable_clk(host);
> +
> +	return 0;
> +}
> +
> +static int uhs2_change_speed(struct mmc_host *host)
> +{
> +	int err;
> +	int timeout = 100;
> +
> +	/* Change Speed Range at controller side. */
> +	if (!host->ops->uhs2_set_reg ||
> +	    host->ops->uhs2_set_reg(host, SET_SPEED_B)) {
> +		pr_err("%s: %s: UHS2 SET_SPEED fail!\n",
> +		       mmc_hostname(host), __func__);
> +		return -EIO;
> +	}
> +
> +	err = uhs2_go_dormant(host, false);
> +	if (err) {
> +		pr_err("%s: %s: UHS2 GO_DORMANT_STATE fail, err= 0x%x!\n",
> +		       mmc_hostname(host), __func__, err);
> +		return -EIO;
> +	}
> +
> +	/* restore sd clock */
> +	mmc_delay(5);
> +	if (host->ops->uhs2_enable_clk)
> +		host->ops->uhs2_enable_clk(host);
> +
> +	/* Enable Normal INT */
> +	if (!host->ops->uhs2_set_reg ||
> +	    host->ops->uhs2_set_reg(host, ENABLE_INT)) {
> +		pr_err("%s: %s: UHS2 ENABLE_INT fail!\n",
> +		       mmc_hostname(host), __func__);
> +		return -EIO;
> +	}
> +
> +	/*
> +	 * According to UHS-II Addendum Version 1.01, chapter 6.2.3,
> +	 * wait card switch to Active State
> +	 */
> +	header = UHS2_NATIVE_PACKET |
> +		 UHS2_PACKET_TYPE_CCMD | host->uhs2_dev_prop.node_id;
> +	arg = ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
> +		UHS2_NATIVE_CMD_READ |
> +		UHS2_NATIVE_CMD_PLEN_8B |
> +		(UHS2_DEV_CONFIG_GEN_SET >> 8);
> +	do {
> +		uhs2_cmd_assemble(&cmd, &uhs2_cmd,
> +				  header, arg,
> +				  NULL, 0,
> +				  NULL, 0);
> +		err = mmc_wait_for_cmd(host, &cmd, 0);
> +		if (err) {
> +			pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
> +			       mmc_hostname(host), __func__, err);
> +			return -EIO;
> +		}
> +
> +		pr_debug("%s: Device Generic Settings Register=0x%x-0x%x\n",
> +			 mmc_hostname(host), cmd.resp[0], cmd.resp[1])
> +		if (cmd.resp[1] & UHS2_DEV_CONFIG_GEN_SET_CFG_COMPLETE) {
> +			pr_debug("%s: %s: UHS2 switch to range B OK\n",
> +				 mmc_hostname(host), __func__);
> +			break;
> +		}
> +
> +		timeout--;
> +		if (timeout == 0) {
> +			pr_err("%s: %s: UHS2 not switch to Active in 100ms.\n",
> +			       mmc_hostname(host->mmc), __func__);
> +			return -EIO;
> +		}
> +
> +		mmc_delay(1);
> +
> +	} while (1);
> +
>  	return 0;
>  }
>  
> @@ -108,8 +822,67 @@ static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
>   * be set through a legacy CMD6. Note that, the power limit that becomes set,
>   * survives a soft reset through the GO_DORMANT_STATE command.
>   */
> -static int sd_uhs2_legacy_init(struct mmc_host *host, struct mmc_card *card)
> +static int sd_uhs2_legacy_init(struct mmc_host *host)
>  {
> +	int err;
> +	u32 ocr, rocr;
> +
> +	WARN_ON(!host->claimed);
> +
> +	/* Send CMD0 to reset SD card */
> +	mmc_go_idle(host);
> +
> +	/* Send CMD8 to communicate SD interface operation condition */
> +	err = mmc_send_if_cond(host, host->ocr_avail);
> +	if (err) {
> +		pr_err("%s: %s: SEND_IF_COND fail!\n",
> +		       mmc_hostname(host), __func__);
> +		return err;
> +	}
> +
> +	/*
> +	 * Get CID, send relative address, get CSD are the same as legacy
> +	 * sd, call mmc_sd_init_card() in sd.c directly
> +	 */
> +	err = mmc_send_app_op_cond(host, 0, &ocr);
> +	if (err) {
> +		pr_err("%s: %s: SD_SEND_OP_COND fail!\n",
> +		       mmc_hostname(host), __func__);
> +		return err;
> +	}
> +
> +	if (host->ocr_avail_sd)
> +		host->ocr_avail = host->ocr_avail_sd;
> +
> +	/*
> +	 * Some SD cards claims an out of spec VDD voltage range. Let's treat
> +	 * these bits as being in-valid and especially also bit7.
> +	 */
> +	ocr &= ~0x7FFF;
> +	rocr = mmc_select_voltage(host, ocr);
> +
> +	/*
> +	 * Some cards have zero value of rocr in UHS-II mode. Assign host's ocr
> +	 * value to rocr.
> +	 */
> +	if (!rocr) {
> +		if (host->ocr_avail) {
> +			rocr = host->ocr_avail;
> +		} else {
> +			pr_err("%s: %s: there is no valid OCR.\n",
> +			       mmc_hostname(host), __func__);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	/*
> +	 * Get CID, send relative address, get CSD are the same as legacy
> +	 * sd, call mmc_sd_init_card() in sd.c directly
> +	 */
> +	err = mmc_sd_init_card(host, rocr, NULL);
> +	if (err) {
> +		pr_err("%s: %s: mmc_sd_init_card() fail!\n",
> +		       mmc_hostname(host), __func__);
> +		return err;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -120,42 +893,49 @@ static int sd_uhs2_legacy_init(struct mmc_host *host, struct mmc_card *card)
>  static int sd_uhs2_init_card(struct mmc_host *host)
>  {
>  	struct mmc_card *card;
> -	u32 node_id;
>  	int err;
>  
>  	err = sd_uhs2_dev_init(host);
> -	if (err)
> +	if (err) {
> +		pr_err("%s: UHS2 DEVICE_INIT fail!\n", mmc_hostname(host));
>  		return err;
> +	}
>  
> -	err = sd_uhs2_enum(host, &node_id);
> +	err = sd_uhs2_enum(host);
> +	if (err) {
> +		pr_err("%s: UHS2 ENUMERATE fail!\n", mmc_hostname(host));
> +		return err;
> +	}
> +
> +	err = sd_uhs2_config_read(host);
>  	if (err)
>  		return err;
>  
> -	card = mmc_alloc_card(host, &sd_type);
> -	if (IS_ERR(card))
> -		return PTR_ERR(card);
> +	err = sd_uhs2_config_write(host);
> +	if (err)
> +		return err;
>  
> -	card->uhs2_config.node_id = node_id;
> -	card->type = MMC_TYPE_SD;
> +	/* Delay some time to let card apply new configuration */
> +	mmc_delay(10);
>  
> -	err = sd_uhs2_config_read(host, card);
> -	if (err)
> -		goto err;
> +	/* Change to Speed Range B if it is supported */
> +	if (host->flags & MMC_UHS2_SPEED_B) {
> +		err = uhs2_change_speed(host);
> +		if (err) {
> +			pr_err("%s: %s: UHS2 uhs2_change_speed() fail!\n",
> +			       mmc_hostname(host), __func__);
> +			return err;
> +		}
> +	}
>  
> -	err = sd_uhs2_config_write(host, card);
> -	if (err)
> -		goto err;
> +	host->flags |= MMC_UHS2_INITIALIZED;
>  
> -	err = sd_uhs2_legacy_init(host, card);
> +	err = sd_uhs2_legacy_init(host);
>  	if (err)
> -		goto err;
> +		return err;
>  
>  	host->card = card;
>  	return 0;
> -
> -err:
> -	mmc_remove_card(card);
> -	return err;
>  }
>  
>  static void sd_uhs2_remove(struct mmc_host *host)
> @@ -234,38 +1014,66 @@ static int sd_uhs2_attach(struct mmc_host *host)
>  	int err;
>  
>  	err = sd_uhs2_power_up(host);
> -	if (err)
> +	if (err) {
> +		pr_debug("%s: %s: sd_uhs2_power_up() fail!\n",
> +			 mmc_hostname(host), __func__);
>  		goto err;
> +	}
>  
>  	err = sd_uhs2_phy_init(host);
> -	if (err)
> +	if (err) {
> +		pr_debug("%s: %s: sd_uhs2_phy_init() fail!\n",
> +			 mmc_hostname(host), __func__);
>  		goto err;
> +	}
>  
>  	err = sd_uhs2_init_card(host);
> -	if (err)
> +	if (err) {
> +		pr_debug("%s: %s: sd_uhs2_init_card() fail!\n",
> +			 mmc_hostname(host), __func__);
>  		goto err;
> +	}
>  
>  	mmc_attach_bus(host, &sd_uhs2_ops);
>  
>  	mmc_release_host(host);
>  
>  	err = mmc_add_card(host->card);
> -	if (err)
> +	if (err) {
> +		pr_debug("%s: %s: mmc_add_card() fail!\n",
> +			 mmc_hostname(host), __func__);
>  		goto remove_card;
> +	}
>  
>  	mmc_claim_host(host);
> +
> +	if (host->ops->uhs2_post_attach_sd)
> +		host->ops->uhs2_post_attach_sd(host);
> +
>  	return 0;
>  
>  remove_card:
> -	mmc_remove_card(host->card);
> -	host->card = NULL;
> +	sd_uhs2_remove(host);
>  	mmc_claim_host(host);
> -	mmc_detach_bus(host);
> +
>  err:
> +	mmc_detach_bus(host);
>  	sd_uhs2_power_off(host);
> +	if (host->flags & MMC_UHS2_INITIALIZED)
> +		host->flags &= ~MMC_UHS2_INITIALIZED;
> +	host->flags &= ~MMC_UHS2_SUPPORT;
>  	return err;
>  }
>  
> +/**
> + * mmc_attach_sd_uhs2 - select UHS2 interface
> + * @host: MMC host
> + *
> + * Try to select UHS2 interface and initialize the bus for a given
> + * frequency, @freq.
> + *
> + * Return:	0 on success, non-zero error on failure
> + */
>  int mmc_attach_sd_uhs2(struct mmc_host *host)
>  {
>  	int i, err = 0;
> @@ -273,8 +1081,12 @@ int mmc_attach_sd_uhs2(struct mmc_host *host)
>  	if (!(host->caps2 & MMC_CAP2_SD_UHS2))
>  		return -EOPNOTSUPP;
>  
> -	/* Turn off the legacy SD interface before trying with UHS-II. */
> -	mmc_power_off(host);
> +	host->flags |= MMC_UHS2_SUPPORT;
> +
> +	if (!(host->caps2 & MMC_CAP2_NO_SDIO))
> +		pr_info("mmc_card_sd_uhs2: sdio\n");
> +	if (!(host->caps2 & MMC_CAP2_NO_SD))
> +		pr_info("mmc_card_sd_uhs2: sd\n");
>  
>  	/*
>  	 * Start UHS-II initialization at 52MHz and possibly make a retry at
> @@ -282,11 +1094,17 @@ int mmc_attach_sd_uhs2(struct mmc_host *host)
>  	 * validates ios->clock, to set a rate within the correct range.
>  	 */
>  	for (i = 0; i < ARRAY_SIZE(sd_uhs2_freqs); i++) {
> -		host->f_init = sd_uhs2_freqs[i];
> -		err = sd_uhs2_attach(host);
> -		if (!err)
> -			break;
> -	}
> +		host->f_init = sd_uhs2_freqs[i];
> +		pr_debug("%s: %s: trying to init card at %u Hz\n",
> +			 mmc_hostname(host), __func__, host->f_init);
>  
> -	return err;
> +		err = sd_uhs2_attach(host);
> +		if (!err)
> +			break;
> +		else
> +			pr_debug("%s: %s: init card at %u Hz failed\n",
> +				 mmc_hostname(host), __func__,
> +				 host->f_init);
> +	}
> +
> +	return err;
>  }
> -- 
> 2.32.0
> 
