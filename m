From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/3] mmc: mvsdio: Convert to devm_ioremap_resource
Date: Tue, 24 Sep 2013 17:37:51 +0530
Message-ID: <CAK9yfHwvD9wfTWzZ5DFUz7Y5DTRof5kUiiCWfnsN_rd1e+SQ_w@mail.gmail.com>
References: <1378968396-18604-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:57957 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906Ab3IXMHw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Sep 2013 08:07:52 -0400
Received: by mail-ob0-f175.google.com with SMTP id uz6so4710444obc.6
        for <linux-mmc@vger.kernel.org>; Tue, 24 Sep 2013 05:07:51 -0700 (PDT)
In-Reply-To: <1378968396-18604-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, Sachin Kamat <sachin.kamat@linaro.org>

On 12 September 2013 12:16, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> devm_request_and_ioremap() is deprecated. Use devm_ioremap_resource()
> instead.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Gentle ping on this series Chris.

-- 
With warm regards,
Sachin
