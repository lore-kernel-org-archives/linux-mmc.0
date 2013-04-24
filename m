From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: [PATCH v2] mmc: core: Fix select power class after resume
Date: Wed, 24 Apr 2013 09:09:18 +0200
Message-ID: <CA+20K0DJ47g0h+Ex1fU+nWxG3eWsc_rFLzL+kzD0oRdynEXSgQ@mail.gmail.com>
References: <1366727227-29848-1-git-send-email-fredrik.soderstedt@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:38189 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754Ab3DXHJT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Apr 2013 03:09:19 -0400
Received: by mail-qc0-f172.google.com with SMTP id b25so785420qca.3
        for <linux-mmc@vger.kernel.org>; Wed, 24 Apr 2013 00:09:19 -0700 (PDT)
In-Reply-To: <1366727227-29848-1-git-send-email-fredrik.soderstedt@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>

Hi,

2013/4/23 Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>:
> Use the saved values in card->ext_csd when selecting power class.
> By doing this the power class will be selected even if mmc_init_card
> is called with oldcard != NULL, which is the case after a suspend/resume.
>
> Today ext_csd is NULL if mmc_init_card is called with oldcard != NULL
> and power class will not be selected.
>
> According to the eMMC specification the POWER_CLASS value is reset after
> power failure, H/W reset assertion and any CMD0 reset.
>
> CC: Girish K S <girish.shivananjappa@linaro.org>
> Signed-off-by: Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>

Looks good to me! Please add my

Reviewed-by: Johan Rudholm <jrudholm@gmail.com>

Kind regards, Johan
