From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 09/27] mmc: mvsdio: Remove redundant suspend and resume
 callbacks
Date: Thu, 26 Sep 2013 11:40:19 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309261136010.312@syhkavp.arg>
References: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org> <1380207292-16968-10-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:56324 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948Ab3IZPkW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Sep 2013 11:40:22 -0400
Received: by mail-qc0-f170.google.com with SMTP id m20so882382qcx.1
        for <linux-mmc@vger.kernel.org>; Thu, 26 Sep 2013 08:40:21 -0700 (PDT)
In-Reply-To: <1380207292-16968-10-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>

On Thu, 26 Sep 2013, Ulf Hansson wrote:

> Suspend and resume of cards are handled by the protocol layer and
> consequently the mmc_suspend|resume_host APIs are marked as deprecated.

Having the protocol layer take care of card suspend is perfectly sound.

However, what about host controllers?  Shouldn't they suspend themselves 
as well?  There is certainly potential for power saving by gating clocks 
to the host IP block or the like.


Nicolas
