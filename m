From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: mmci: avoid clearing ST Micro busy end interrupt mistakenly
Date: Tue, 7 Feb 2017 22:31:32 +0100
Message-ID: <CACRpkdbGzkPX34uQnyfRVmSxtQAsG1w4u3-_vECPUGmsKVn9Hw@mail.gmail.com>
References: <1486465961-22942-1-git-send-email-jean-nicolas.graux@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:35685 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754677AbdBGVbe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Feb 2017 16:31:34 -0500
Received: by mail-it0-f50.google.com with SMTP id 203so86924123ith.0
        for <linux-mmc@vger.kernel.org>; Tue, 07 Feb 2017 13:31:34 -0800 (PST)
In-Reply-To: <1486465961-22942-1-git-send-email-jean-nicolas.graux@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jean-Nicolas Graux <jean-nicolas.graux@st.com>, Sarang Mairal <sarang.mairal@garmin.com>
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Tue, Feb 7, 2017 at 12:12 PM, Jean-Nicolas Graux
<jean-nicolas.graux@st.com> wrote:

> This fixes a race condition that may occur whenever ST micro busy end
> interrupt is raised just after being unmasked but before leaving mmci
> interrupt context.
(...)
> This patch has been tested with the ST Accordo5 machine that is not
> upstreamed yet but that relies on mmci upstreamed driver.
>
> Signed-off-by: Sarang Mairal <sarang.mairal@garmin.com>
> Signed-off-by: Jean-Nicolas Graux <jean-nicolas.graux@st.com>

Such impressive bug tracking fro you guys, hats off!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Ulf can you apply this for fixes?

Yours,
Linus Walleij
