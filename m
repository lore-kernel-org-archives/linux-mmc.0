From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pxav3: Use sdhci_get_of_property for parsing
 DT quirks
Date: Thu, 20 Sep 2012 10:06:22 +0800
Message-ID: <CAMj5BkiG0Wmwt_UZXxkN4HkLANJquY+kX0agPn8vi__JbnxcTA@mail.gmail.com>
References: <87mx0zzyin.fsf@octavius.laptop.org>
	<CAN1soZzebpiQB_7HW80xnqEqqVJumiDxPQ3jqx_8ezBRMr6TZg@mail.gmail.com>
	<87d31sy548.fsf@octavius.laptop.org>
	<m3lig6h0xw.fsf_-_@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:50423 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765Ab2ITCGX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Sep 2012 22:06:23 -0400
Received: by wibhr14 with SMTP id hr14so34560wib.1
        for <linux-mmc@vger.kernel.org>; Wed, 19 Sep 2012 19:06:22 -0700 (PDT)
In-Reply-To: <m3lig6h0xw.fsf_-_@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>, Zhangfei Gao <zhangfei.gao@marvell.com>

On Wed, Sep 19, 2012 at 4:27 PM, Chris Ball <cjb@laptop.org> wrote:
> In particular, this is done to gain support for broken-cd and wp-inverted.
>
> Signed-off-by: Chris Ball <cjb@laptop.org>
> ---
> (A previously submitted patch of mine added broken-cd support to
> sdhci-pxav3 directly; I think it's a better idea to discard that
> patch and use this one instead.)

Thanks Chris, it's really better.
Acked-by: Zhangfei Gao <zhangfei.gao@marvell.com>
