Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A95C433DB
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Feb 2021 20:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A31264E31
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Feb 2021 20:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhBVUNf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Feb 2021 15:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhBVUNe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Feb 2021 15:13:34 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A43C06178A
        for <linux-mmc@vger.kernel.org>; Mon, 22 Feb 2021 12:12:53 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id j19so7672475lfr.12
        for <linux-mmc@vger.kernel.org>; Mon, 22 Feb 2021 12:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zl/6QdQx9DNe9MuBskyngySVB9zc0WYpCOGtZfravdQ=;
        b=rPAmVrTodH3OaZ26+CFkdsSmgJKkETd8bSzra+VHbJojKzyJzD/JBdlURaBMqFIkKj
         sl4R/yGzPPDfGklq0I4BAyEqtvtE8rO941oceZpvY9DTAp4mSr+CWHlc9QVjPqPZDbwO
         LZrizgpmU0FV5SzjSm0iz2rrFA7MrV9Vl09ToaMVqZILviseIIOEpAs57zzDn9p2Fw35
         Ldrjq6GZLhAsU46dTOxMHISwTlt9RteCjjMfH8/MhpJawoMKlrm+s4p2TsFdDggWdWuQ
         7+wJvITyGmKhrdZcB66vl29Z3Sy4oAdM8JlSZjLL+j+TF0rwepiEt7F7YTQsFkZFMjiK
         /CEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zl/6QdQx9DNe9MuBskyngySVB9zc0WYpCOGtZfravdQ=;
        b=GGAPoZDJkzd3cVhh+d+JzSwpui0SgrDyJyfeuz0cGJthRSjYSLEku6yjkiWkcFIO2Y
         thCX8FETpB6b2cc3g+QJ1Arw29+oS8Pcm0fvAgKBwnKKtZBOhVPywDyoby1E73iZeRF3
         KFN5NMSOc4K6kscCNVkn7k5sK+28U1asjZrHEy/2z9YZcMQ/uvi8EfvqhZjoB0npgIby
         X2IeJW7V1gaXKYpZrxmqPEgyGvvDxjfTnriZg8pDa2RkOZlappYwotIpO6I3p+nl0KIT
         etJPVB4Cl9ec9Y9d/3Y7FW8EPO4LeCBCUUP3zt0K2bibZXFel+CcHQguAjG6vypifuT6
         XgMA==
X-Gm-Message-State: AOAM531uE+KqcWbXA9bR7rMzkb21ltKZGotx9BeP1KnbQBDZwm6zw6Eq
        MIBJAVE/OHwhqZS30hQi+PNgFgyfoUo=
X-Google-Smtp-Source: ABdhPJzvcU5r7H/S64EQx+eJZKmuxY2tlT6Ivp4q/iyr5d8pQ+4CMjRtR8p3i9Ly/uBPlw5cFDwKkg==
X-Received: by 2002:a05:6512:1081:: with SMTP id j1mr15252496lfg.398.1614024771582;
        Mon, 22 Feb 2021 12:12:51 -0800 (PST)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id 189sm2306245ljj.51.2021.02.22.12.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 12:12:51 -0800 (PST)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
        by home.paul.comp (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTP id 11MKClFF022160;
        Mon, 22 Feb 2021 23:12:48 +0300
Received: (from paul@localhost)
        by home.paul.comp (8.15.2/8.15.2/Submit) id 11MKCkA1022159;
        Mon, 22 Feb 2021 23:12:46 +0300
Date:   Mon, 22 Feb 2021 23:12:45 +0300
From:   Paul Fertser <fercerpav@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, mirq-linux@rere.qmqm.pl
Subject: Re: [PATCH 3/3] mmc: core: Default to generic_cmd6_time as timeout
 in __mmc_switch()
Message-ID: <20210222201245.GW2059@home.paul.comp>
References: <20200122142747.5690-1-ulf.hansson@linaro.org>
 <20200122142747.5690-4-ulf.hansson@linaro.org>
 <20210222162406.GA17142@home.paul.comp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222162406.GA17142@home.paul.comp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Feb 22, 2021 at 07:24:06PM +0300, Paul Fertser wrote:
> On Wed, Jan 22, 2020 at 03:27:47PM +0100, Ulf Hansson wrote:
> > All callers of __mmc_switch() should now be specifying a valid timeout for
> > the CMD6 command.
> 
> I'm running a kernel based on linux-next on a Tegra2 system (Toshiba
> ac100 aka paz00, on-board eMMC) and seeing plenty of these warnings on
> boot. I added WARN_ON_ONCE to see the backtrace and here's what I get:
...
> [    3.338454] [<c063d8a4>] (mmc_switch) from [<c0648f48>] (mmc_blk_mq_issue_rq+0x22c/0x900)
> [    3.396728] [<c0648f48>] (mmc_blk_mq_issue_rq) from [<c064998c>] (mmc_mq_queue_rq+0x124/0x258)
> [    3.409215] [<c064998c>] (mmc_mq_queue_rq) from [<c039a9e8>] (__blk_mq_try_issue_directly+0x140/0x1cc)

FWIW, with

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index f5dedb7f9b27..9adf735391fa 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -426,8 +426,7 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
                /* EXT_CSD value is in units of 10ms, but we store in ms */
                card->ext_csd.part_time = 10 * ext_csd[EXT_CSD_PART_SWITCH_TIME];
                /* Some eMMC set the value too low so set a minimum */
-               if (card->ext_csd.part_time &&
-                   card->ext_csd.part_time < MMC_MIN_PART_SWITCH_TIME)
+               if (card->ext_csd.part_time < MMC_MIN_PART_SWITCH_TIME)
                        card->ext_csd.part_time = MMC_MIN_PART_SWITCH_TIME;

                /* Sleep / awake timeout in 100ns units */

I do not see any more warnings on my system.

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com
