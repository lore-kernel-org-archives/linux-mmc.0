Return-Path: <SRS0=9sJp=55=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45397C2BA19
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Apr 2020 06:53:01 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A0420735
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Apr 2020 06:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ylx+UI57"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A0420735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mmc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgDMGxA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Apr 2020 02:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbgDMGxA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Apr 2020 02:53:00 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07FCC008651;
        Sun, 12 Apr 2020 23:52:58 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h25so7702940lja.10;
        Sun, 12 Apr 2020 23:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=obx+dgHWtJ+1SmS5nRQdHXALDhbm+OoO8gaF5G34Y6g=;
        b=Ylx+UI57UMaItJSNaHrmSCBTsp8MTvIoeG+yFhELcHVTOCotrj+JnfujPbwWPlz8mu
         mPOwVLUV3ZUX8lyK+/4pPbyD1ChVeJ8BPnIkO/KaDNfZrCbOGmu4Myc3zjz5AaVvSxoq
         YW6AfSVO3t69PQUMY3lAsn+4ILrolNOIr03CQkyJFtEX+B7ezjYdjcha3Q7FoqI58KN7
         WEg1Sb63OY82K1DTm9Oh6Mkq94lKJrguk7AOZy4Cf1R1FCz0FF8y3GRbcPtSu+LpQL90
         d10Ekjk0/ufHkPCsJknjlK5sbBaumnoq5OVtpwlwpsCsWwBhQgL2LvVY0pMTjr9WIbF+
         hIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=obx+dgHWtJ+1SmS5nRQdHXALDhbm+OoO8gaF5G34Y6g=;
        b=A3qaPLrvZfLhSwBNtviJx0zaaFtzADW/4AaZBgjWFtxMMRBqYH8QZN6Q023f6Bsi+Y
         DoDW2wyFLgubpgJUcHUZTBTO8kOjRboQfgEShaZAypYSi6Iz6FNEydHIHZkmG7h+VQOZ
         ZUFsq6kiKf0LUUfe7NrACHsEFI+Bm/23YdmLmrecX3F4GKj74Dx3D5deOZIa/iDUKrvI
         hEYi3c12ILCkeJT+Ug2OLtB2JJtxstYFcxuWDzxbf9+fyvkb9at+KmsMXhamga8OMTZD
         r0bL7A+n3vy1fVkXLMcgGGKxN6cORFPLCaSq765eDuGpWqqLGUX/XS10KlWZmLARmabW
         m5ZA==
X-Gm-Message-State: AGi0Pubzlus3bkDuaN5M5F0rxOy8IF1GtxODdZ/tvXjTjaEXfdXanAG1
        AGPA1m88dWRnfH0CLf5AG6QXgWIXPzJzxGtZLuc=
X-Google-Smtp-Source: APiQypKuExun26bef57tFMBC0VASpQa9TO67TMeZBmY+f4n/zZ8Cd8v7LctbSsl2eIyIEMKAZtGbpKcis4zSbRUqjiY=
X-Received: by 2002:a2e:330e:: with SMTP id d14mr9669168ljc.153.1586760777124;
 Sun, 12 Apr 2020 23:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <9ed34afa9fb42e0c234065cac5401d7826942b55.1586744073.git.baolin.wang7@gmail.com>
 <202004131350.ewIW96s2%lkp@intel.com>
In-Reply-To: <202004131350.ewIW96s2%lkp@intel.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Mon, 13 Apr 2020 14:52:45 +0800
Message-ID: <CADBw62oRnPr6K0C_1QsQdpZGMJvaQ4dymnVDxgfPsRt9m=t72A@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] mmc: host: sdhci: Implement the request_atomic() API
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Mon, Apr 13, 2020 at 1:42 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Baolin,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v5.7-rc1 next-20200412]
> [cannot apply to arm-soc/for-next]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Baolin-Wang/Introduce-the-request_atomic-for-the-host/20200413-105346
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 8f3d9f354286745c751374f5f1fcafee6b3f3136
> config: x86_64-randconfig-s2-20200413 (attached as .config)
> compiler: gcc-5 (Ubuntu 5.5.0-12ubuntu1) 5.5.0 20171010
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>

This patch set is based on Adrian's patch set. Thanks.
https://www.spinics.net/lists/linux-mmc/msg58529.html

>
> All error/warnings (new ones prefixed by >>):
>
>    In file included from include/linux/build_bug.h:5:0,
>                     from include/linux/bitfield.h:10,
>                     from drivers/mmc/host/sdhci.c:12:
>    drivers/mmc/host/sdhci.c: In function 'sdhci_request_atomic':
>    drivers/mmc/host/sdhci.c:2076:6: error: implicit declaration of function 'sdhci_present_error' [-Werror=implicit-function-declaration]
>      if (sdhci_present_error(host, mrq->cmd, true)) {
>          ^
>    include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
>     #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
>                                                        ^
> >> drivers/mmc/host/sdhci.c:2076:2: note: in expansion of macro 'if'
>      if (sdhci_present_error(host, mrq->cmd, true)) {
>      ^
>    drivers/mmc/host/sdhci.c:2081:8: error: implicit declaration of function 'sdhci_manual_cmd23' [-Werror=implicit-function-declaration]
>      cmd = sdhci_manual_cmd23(host, mrq) ? mrq->sbc : mrq->cmd;
>            ^
>    drivers/mmc/host/sdhci.c:2090:2: error: invalid use of void expression
>      if (!sdhci_send_command(host, cmd))
>      ^
>    drivers/mmc/host/sdhci.c:2090:2: error: invalid use of void expression
>    In file included from include/linux/build_bug.h:5:0,
>                     from include/linux/bitfield.h:10,
>                     from drivers/mmc/host/sdhci.c:12:
> >> include/linux/compiler.h:61:16: error: invalid use of void expression
>      static struct ftrace_branch_data  \
>                    ^
>    include/linux/compiler.h:58:69: note: in expansion of macro '__trace_if_value'
>     #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
>                                                                         ^
>    include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
>     #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
>                                ^
>    drivers/mmc/host/sdhci.c:2090:2: note: in expansion of macro 'if'
>      if (!sdhci_send_command(host, cmd))
>      ^
>    cc1: some warnings being treated as errors
>
> vim +/if +2076 drivers/mmc/host/sdhci.c
>
>   2066
>   2067  int sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq)
>   2068  {
>   2069          struct sdhci_host *host = mmc_priv(mmc);
>   2070          struct mmc_command *cmd;
>   2071          unsigned long flags;
>   2072          int ret = 0;
>   2073
>   2074          spin_lock_irqsave(&host->lock, flags);
>   2075
> > 2076          if (sdhci_present_error(host, mrq->cmd, true)) {
>   2077                  sdhci_finish_mrq(host, mrq);
>   2078                  goto out_finish;
>   2079          }
>   2080
>   2081          cmd = sdhci_manual_cmd23(host, mrq) ? mrq->sbc : mrq->cmd;
>   2082
>   2083          /*
>   2084           * The HSQ may send a command in interrupt context without polling
>   2085           * the busy signaling, which means we should return BUSY if controller
>   2086           * has not released inhibit bits to allow HSQ trying to send request
>   2087           * again in non-atomic context. So we should not finish this request
>   2088           * here.
>   2089           */
>   2090          if (!sdhci_send_command(host, cmd))
>   2091                  ret = -EBUSY;
>   2092          else
>   2093                  sdhci_led_activate(host);
>   2094
>   2095  out_finish:
>   2096          spin_unlock_irqrestore(&host->lock, flags);
>   2097          return ret;
>   2098  }
>   2099  EXPORT_SYMBOL_GPL(sdhci_request_atomic);
>   2100
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
Baolin Wang
