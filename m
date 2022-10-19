Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A105C433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Oct 2022 14:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiJSOlc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 Oct 2022 10:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiJSOlR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Oct 2022 10:41:17 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290C31929B0
        for <linux-mmc@vger.kernel.org>; Wed, 19 Oct 2022 07:26:35 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id p14so17404919pfq.5
        for <linux-mmc@vger.kernel.org>; Wed, 19 Oct 2022 07:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jzg5yqqVny0bc5UsUG57Vxbngi6ZDDzUKYq6ZlGVglA=;
        b=Zn7aSZ/cNeVXUNKWQHFM/ZWrRLSfuiIbEOjxRlg7DOY3RYUzDEgypOxZG2Qdpx1WGR
         EBSGjQIn+WysGN4/+XKw8njeNCgBmEsHseL91wuLT3QSCqY3JI6Oha8vLkpqIp0NMkf+
         acB5yQfHTpqk6dNxddhJV0uhIaMVoZ0OAT5gG5BdUmVe4Bl42Nu1ybPmll0nyS4l1uTF
         +FlmptKqKm5KSgWgHSroA9wPSaSO36UE3YcBezctU7FIctwJf+C35P9ac3jWohGFWsMM
         43okpDQJwPnqMBPRTF8LqHCvN3G1FJDV60ZW5GkQTA38zaxvtGdt9tbLV454DcOwDlkq
         1svQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jzg5yqqVny0bc5UsUG57Vxbngi6ZDDzUKYq6ZlGVglA=;
        b=LBGHBRk2xEgVVCM/7HmqKgnXADyd4xBaLzLQyrHh+MRizJqXMvVpwa2dkW5KbqzUSV
         K5f893RFtm/de8euifM0jnH10yWFiu2ttNxUYNrOiXoaIB+tIFGW1EhZg3nxDdG/ruYk
         OnR0DTDbX0ZH3e1kd3bDNc64cKtqCSpt6SPJpXg0NsJdIEAEJFcHyszQmj9EzscPRiZt
         NZosO3f1vD/4kccJApvirVosErXcTezeALMs4k6v7Qf1LQyJVB4zzHEagwbzAcZ9CUeq
         6TpB2xDgT3jGWOx6QfYCw9ZiGBgsfp3d+bB4Rqh3TBBbNBCG7csa5ZrIPlgZaSBXJ6Ar
         9XSA==
X-Gm-Message-State: ACrzQf1ngNDkNC6at1iTBykJvVjVlFdh3yz6htuiDoQopoIww6pisKh4
        Yr17XxYP2YpHD94UTYLenC3I1jTCU8yDsg1JwEg=
X-Google-Smtp-Source: AMsMyM4DyQ8DdaHQLziNc1q2EWGyQC1vbDsMr1Yg+XzhXPiKG+9Jz0HbqfadgbxpCECmulX5QzkVxYsJQwXrs+cqPb4=
X-Received: by 2002:a63:555e:0:b0:43c:4f2e:dd25 with SMTP id
 f30-20020a63555e000000b0043c4f2edd25mr7644271pgm.131.1666189594333; Wed, 19
 Oct 2022 07:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5DCbC6MK=O1t20nLNKf2Oipf-Ar1TkHU+o9Bvpr0JRtxQ@mail.gmail.com>
 <VI1PR04MB40163FEB8AEC32F55E51931890D69@VI1PR04MB4016.eurprd04.prod.outlook.com>
 <CAOMZO5Dmk_OWTZGEafTZO451Zo6W8UMUJAZguW85y0b2BmCpWA@mail.gmail.com>
 <CAOMZO5CYvbd3uTKxq6suyn5H0yNU1R7tsgbawNdwjEbKgdt6bg@mail.gmail.com>
 <CAOMZO5C-5M8y=V1L6Qdqymhb-1oOpBszFwuWCxedUJ1oO7=ADw@mail.gmail.com>
 <DB7PR04MB4010FBDF45A7BDD40D02004E902B9@DB7PR04MB4010.eurprd04.prod.outlook.com>
 <CAOMZO5AvRHyeJCQemXnab3Z8n=-9eKDKYqA=CRbMEhG89QEvFQ@mail.gmail.com>
In-Reply-To: <CAOMZO5AvRHyeJCQemXnab3Z8n=-9eKDKYqA=CRbMEhG89QEvFQ@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 19 Oct 2022 11:26:25 -0300
Message-ID: <CAOMZO5Dq67h8nA4T0pYR1z4dbhW-HSGk529dELjbLSs=k1YojA@mail.gmail.com>
Subject: Re: imx7d: Timeout waiting for hardware interrupt.
To:     Bough Chen <haibo.chen@nxp.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Martin Fuzzey <martin.fuzzey@flowbird.group>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Bough,

On Wed, Oct 19, 2022 at 10:10 AM Fabio Estevam <festevam@gmail.com> wrote:

> Or any other suggestions?

I am wondering if we are seeing some kind of clock glitch due to the
way that runtime suspend/resume are handled.

Currently, esdhc_pltfm_set_clock() changes the clock while ahb and ipg
clocks are on, which could be problematic.

I think we only need the per clock turned on while changing the clocks
inside esdhc_pltfm_set_clock().

What do you think about the change below?

https://pastebin.com/raw/U9KrHM1C

Thanks
