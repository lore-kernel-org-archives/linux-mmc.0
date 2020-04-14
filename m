Return-Path: <SRS0=djOR=56=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECABC2BA19
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 18:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C96B820575
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 18:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="qYgFsAsa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504116AbgDNSkJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:40:09 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:20322 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504142AbgDNSkH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 14 Apr 2020 14:40:07 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 491vRl26dgzZ5;
        Tue, 14 Apr 2020 20:40:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1586889605; bh=kAvGX9pOIPQrCzJXDeL1+Ys815lqtmHIeG4WQmjxbTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qYgFsAsaQBvMFqmoUjH+bFcjyf2oq3kZYcG/AvFzD49Rq65miu4+/48so7Bcon/SU
         o+ltd7JJMYHTSI2O84xQXbS1FyjO4uqFPfEecVpQ5xKW8cy4xkh4fmkCt3bHSD5xpi
         sMrXjLQy+YNEiKdN1AUB2YBtgGbt1QNy4FMtowdMGNmJeK7igGYecEDbiUBKvAUp59
         AZlGgT7bngA1ChHw0aF0jtzKJdP1/Dc84nF3x6YuTFP8zYChHM3cIiHao3zICXiUgR
         isE3wX2MErPnEWUfbmymkou//Ho+sUnLBUhCGQ3in/6/AMBmuiF4m0xx1IHuTHdEYf
         zTw6+ymiiDt7g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Tue, 14 Apr 2020 20:39:59 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan =?iso-8859-2?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Bruce Chang <brucechang@via.com.tw>,
        Harald Welte <HaraldWelte@viatech.com>,
        Alex Dubov <oakad@yahoo.com>,
        Sascha Sommer <saschasommer@freenet.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH 06/19] mmc: cb710: Inform the mmc core about the maximum
 busy timeout
Message-ID: <20200414183959.GA15141@qmqm.qmqm.pl>
References: <20200414161413.3036-1-ulf.hansson@linaro.org>
 <20200414161413.3036-7-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200414161413.3036-7-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Apr 14, 2020 at 06:14:00PM +0200, Ulf Hansson wrote:
> Some commands uses R1B responses, which means the card may assert the DAT0
> line to signal busy for a period of time, after it has received the
> command. The mmc core normally specifies the busy period for the command in
> the cmd->busy_timeout. Ideally the driver should respect it, but that
> requires quite some update of the code, so let's defer that to someone with
> the HW at hand.
> 
> Instead, let's inform the mmc core about the maximum supported busy timeout
> in ->max_busy_timeout during ->probe(). This value corresponds to the fixed
> ~2s timeout of the polling loop, implemented in cb710_wait_for_event(). In
> this way, we let the mmc core validate the needed timeout, which may lead
> to that it converts from a R1B into a R1 response and then use CMD13 to
> poll for busy completion.
> 
> In other words, this change enables support for commands with longer busy
> periods than 2s, like erase (CMD38) for example.
[...]
> +	/*
> +	 * In cb710_wait_for_event() we use a fixed timeout of ~2s, hence let's
> +	 * inform the core about it. A future improvement should instead make
> +	 * use of the cmd->busy_timeout.
> +	 */
[...]

I'm not sure whether the controller limits busy signalling time.
Since this is rare HW now, I would just pass the timeout to
cb710_wait_for_event() and see if someone reports a bug.

Best Regards,
Micha³ Miros³aw
