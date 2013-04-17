From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: [PATCH] mmc: core: Only execute tuning for SDR50 and SDR104
Date: Wed, 17 Apr 2013 15:10:49 +0200
Message-ID: <CA+20K0DFMyhveE6MTjBjQ2m_46S7STtY7Rpn6T-wbL3vsp7OWw@mail.gmail.com>
References: <1366199453-6135-1-git-send-email-fredrik.soderstedt@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:50755 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965778Ab3DQNKu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Apr 2013 09:10:50 -0400
Received: by mail-qa0-f54.google.com with SMTP id j8so844788qah.13
        for <linux-mmc@vger.kernel.org>; Wed, 17 Apr 2013 06:10:49 -0700 (PDT)
In-Reply-To: <1366199453-6135-1-git-send-email-fredrik.soderstedt@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>

Hi,

2013/4/17 Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>:
> Only execute tuning for sd and sdio devices that are using
> SDR50 or SDR104.
>
> Make sure clock is hold during tuning for sdio devices.
>
> Signed-off-by: Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>

Acked-by: Johan Rudholm <jrudholm@gmail.com>

//Johan
