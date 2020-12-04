Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D19C4361A
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 18:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB59022AAF
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 18:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgLDSFR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Dec 2020 13:05:17 -0500
Received: from aposti.net ([89.234.176.197]:52870 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgLDSFR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 4 Dec 2020 13:05:17 -0500
Date:   Fri, 04 Dec 2020 18:04:19 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] mmc: mediatek: mark PM functions as __maybe_unused
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        yong mao <yong.mao@mediatek.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Marek Vasut <marex@denx.de>, linux-mmc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ARM/Mediatek SoC support <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Message-Id: <77UTKQ.VC4AUEXP1CN21@crapouillou.net>
In-Reply-To: <CAK8P3a3srmTdY69j+g-wazMkrTL8_Grsw=vCMyizyA_7oOC4tg@mail.gmail.com>
References: <20201203222922.1067522-1-arnd@kernel.org>
        <CAPDyKFqtFYqc8i_fVzOUnuZGJjtwjVLqE-vebtOKuYJ-4PrDBg@mail.gmail.com>
        <CAK8P3a3srmTdY69j+g-wazMkrTL8_Grsw=vCMyizyA_7oOC4tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

Le ven. 4 déc. 2020 à 15:14, Arnd Bergmann <arnd@kernel.org> a écrit 
:
> On Fri, Dec 4, 2020 at 11:02 AM Ulf Hansson <ulf.hansson@linaro.org> 
> wrote:
>>  On Thu, 3 Dec 2020 at 23:29, Arnd Bergmann <arnd@kernel.org> wrote:
> 
>>  > -#ifdef CONFIG_PM
>>  >  static void msdc_save_reg(struct msdc_host *host)
>> 
>>  Shouldn't msdc_save|restore_reg() be turned into "__maybe_unused" 
>> as well?
> 
> There is no need since the compiler can figure that out already when 
> there
> is a reference to the function from dead code.
> 
>>  >
>>  > -static int msdc_resume(struct device *dev)
>>  > +static int __maybe_unused msdc_resume(struct device *dev)
>>  >  {
>>  >         return pm_runtime_force_resume(dev);
>>  >  }
>>  > -#endif
>>  >
>>  >  static const struct dev_pm_ops msdc_dev_pm_ops = {
>> 
>>  You may also change this to a __maybe_unused, as long as you also
>>  assign the .pm pointer in the mt_msdc_driver with
>>  pm_ptr(&msdc_dev_pm_ops).
>> 
>>  Ideally the compiler should drop these functions/datas entirely 
>> then.
> 
> I don't see a lot of other instances of that yet, and it's fairly new.
> Maybe we should fix it before it gets propagated further.
> 
> I would suggest we redefine pm_ptr like
> 
> #define pm_ptr(_ptr) (IS_ENABLED(CONFIG_PM) ? (_ptr) : NULL)
> 
> and remove the __maybe_unused annotations on those that we
> already have. This also has the effect of dropping the unused
> data from the object, but without having to an an #ifdef or
> __maybe_unused.
> 
> Adding Paul and Rafael to Cc for clarification on this.

I didn't think about that. That's smarter and much more elegant.

Cheers,
-Paul


