Return-Path: <SRS0=djOR=56=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5541C2BA19
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AD8C2076B
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 16:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LPbdwnKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391336AbgDNQQj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389792AbgDNQOU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Apr 2020 12:14:20 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247B9C061A0C
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:20 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id d8so396311ljo.6
        for <linux-mmc@vger.kernel.org>; Tue, 14 Apr 2020 09:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ofxdCuIxfi4VwJPFI7E0O8iIllI/SqzGq8DUbhk0hrk=;
        b=LPbdwnKN8ICt++aO2TSsqXjSmIsgZx7GP5D+L4sm+2RIPp445kkQREv2PMMftCypeu
         LDVJWEZmYU72XKyNATVLPQ+BZRT/JylxEE9UTW4qatoq0MSymq1CsCKIXcJtzDGuW9Ij
         igGYn0k4+6P+Wcct2yF8qo8S6thWMuM/oKdfkICOYa3/t/UzglVXAxtMQJ8pOWimv36t
         mkJkofrmc0NtK2cgkfvLrnDiHvlgs39D0f5w68yqYhpoWzPAY8r9jqzStGYoZJaf6nS6
         UJZdvwZZDghg9wnTHAJuHgfMVZ5GeRb67fnbomElhioBH0CnQCNvtB654b/o2vG9wRHJ
         R6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ofxdCuIxfi4VwJPFI7E0O8iIllI/SqzGq8DUbhk0hrk=;
        b=UXJHwDSWQ9TLcxktwjFZfwml/53uqeCgc/+QPo5egD6MmDqtv7ZT8NQVZlGx/CQXTl
         j5C/EQQrRJa5FUtUIuuI7ieFDYaRVcl0nuCAs+UuYqnos6XOiw70kfxMQVXLfv9oOFy4
         gcXFLz8oH3KNaNxnCKNNHlc+s3Qkk7t0WNfVIa/NfEuMrhu9553hXfIUXrtqCWpVK4iM
         8LhSGmHYdBgoxW9bv6mPVpRf2LmqM+VVK9MoPG/1wGMbteLZ4g23a6/8YQntAMju3n3E
         U5Si+Igt53qnWswfZ46vf0R6UM5sbHcyaN6igg58a8UlQJ08jMwnOc2xYkrALSgYKU5O
         WZNQ==
X-Gm-Message-State: AGi0Pub9Qy0p6Vl/M1/z2LNvPYqrXAKxPRIC2OtM/1s2IMxRWjY1olW1
        wL89AhFusAUE7GfFG94+ISdBt9RKDZg=
X-Google-Smtp-Source: APiQypL1hB/Tm7z9X3vfM2HUhIoic0WefEK/E3+ekVGuAtxgBpx3HI7aGlXaGUqgzPQFhsDVzPNB8w==
X-Received: by 2002:a2e:9b41:: with SMTP id o1mr558595ljj.145.1586880857969;
        Tue, 14 Apr 2020 09:14:17 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-131.NA.cust.bahnhof.se. [98.128.181.131])
        by smtp.gmail.com with ESMTPSA id a26sm9330669ljn.22.2020.04.14.09.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:14:17 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Bruce Chang <brucechang@via.com.tw>,
        Harald Welte <HaraldWelte@viatech.com>,
        Alex Dubov <oakad@yahoo.com>,
        Sascha Sommer <saschasommer@freenet.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mirq-linux@rere.qmqm.pl, Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 00/19] mmc: Improve host driver's support for R1B responses
Date:   Tue, 14 Apr 2020 18:13:54 +0200
Message-Id: <20200414161413.3036-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Some MMC/SD commands uses R1B responses, which means the card may assert the DAT0 line
to signal busy for a period of time, after it has received the command. The mmc
core normally specifies the busy period for the command in the
cmd->busy_timeout. Ideally the driver should respect it, but that isn't always
the case, for several reasons.

For example, the mmc host may not even support HW busy signal
detection, the HW may have a build-in upper limit of the timeout and the driver
simply uses that or it uses some other internal command/request SW timeout
mechanism with another timeout value.

In cases when the host driver can't support a cmd->busy_timeout, the core
implements a fallback method, which is based upon sending CMD13 to poll the card
about the status instead. However, to make this work, the host driver need to
specify the mmc->max_busy_timeout, as to make the core aware of when to use the
fallback method with CMD13 polling.

Step by step, host drivers has been improved to better cope with the above
scenarios. Although in this series, I have walked through *all* host drivers and
those that looked particularly suspicious I have fixed.

Note, none of the changes has been tested on HW, so I am relying on help with
this.

The next step beyond this series is to make MMC_CAP_ERASE default enabled, as
that would trigger CMD38 to be used. CMD38 uses the R1B response and may
typically require longer busy periods to be supported.

Kind regards
Ulf Hanssom


Ulf Hansson (19):
  mmc: atmel-mci: Keep timer enabled when queuing a next request
  mmc: atmel-mci: Set the timer per command rather than per request
  mmc: atmel-mci: Respect the cmd->busy_timeout from the mmc core
  mmc: jz4740: Inform the mmc core about the maximum busy timeout
  mmc: usdhi6rol0: Inform the mmc core about the maximum busy timeout
  mmc: cb710: Inform the mmc core about the maximum busy timeout
  mmc: owl-mmc: Respect the cmd->busy_timeout from the mmc core
  mmc: sdricoh_cs: Drop unused defines
  mmc: sdricoh_cs: Use MMC_APP_CMD rather than a hardcoded number
  mmc: sdricoh_cs: Move MMC_APP_CMD handling to sdricoh_mmc_cmd()
  mmc: sdricoh_cs: Drop redundant in-parameter to sdricoh_query_status()
  mmc: sdricoh_cs: Throttle polling rate for data transfers
  mmc: sdricoh_cs: Throttle polling rate for commands
  mmc: sdricoh_cs: Respect the cmd->busy_timeout from the mmc core
  mmc: tifm_sd: Inform the mmc core about the maximum busy timeout
  mmc: via-sdmmc: Respect the cmd->busy_timeout from the mmc core
  mmc: mmc_spi: Add/rename defines for timeouts
  mmc: mmc_spi: Respect the cmd->busy_timeout from the mmc core
  staging: greybus: sdio: Respect the cmd->busy_timeout from the mmc
    core

 drivers/mmc/host/atmel-mci.c   |  12 ++--
 drivers/mmc/host/cb710-mmc.c   |   8 +++
 drivers/mmc/host/jz4740_mmc.c  |  13 ++++-
 drivers/mmc/host/mmc_spi.c     |  20 +++----
 drivers/mmc/host/owl-mmc.c     |   8 ++-
 drivers/mmc/host/sdricoh_cs.c  | 103 +++++++++++++++++----------------
 drivers/mmc/host/tifm_sd.c     |   9 ++-
 drivers/mmc/host/usdhi6rol0.c  |   9 ++-
 drivers/mmc/host/via-sdmmc.c   |   7 ++-
 drivers/staging/greybus/sdio.c |  10 +++-
 10 files changed, 125 insertions(+), 74 deletions(-)

-- 
2.20.1

