Return-Path: <SRS0=OWc9=4P=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A42AC35E1C
	for <linux-mmc@archiver.kernel.org>; Thu, 27 Feb 2020 20:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37C32468E
	for <linux-mmc@archiver.kernel.org>; Thu, 27 Feb 2020 20:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S7ZikkXj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgB0Uy4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 27 Feb 2020 15:54:56 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:44592 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbgB0Uyz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Feb 2020 15:54:55 -0500
Received: by mail-ua1-f67.google.com with SMTP id a33so165456uad.11
        for <linux-mmc@vger.kernel.org>; Thu, 27 Feb 2020 12:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ktzdl5eoKPEHfEuFryFzhZR7Y8sf35Stxv0I9TC3om8=;
        b=S7ZikkXjTCFqfTODdrBIRR4bjKV6vzJmi95TuJOiGc6qU7zDytV2WPccOPkdOwJZ/j
         xli5qKpWBUJ5DazclKwIIfQ8qQMD4fHsNAqdGsEEL4fe3MO0gOR/KmwhvFgRCgvvNvHb
         vijRWYbIUdJ6HmZd/RojRMwFkBppkvmsy5rbTLnwbctZAx6wUY1nJDyxeEApFNEB55Xb
         U/d0YaxRhAe8wd8cADEZdNzur4hfxn5jgLkmh8HD1TUN6quVjk+WYUszsrJcPsODuhpU
         y/6+8DOFTaL7D7XPV1o3rvMBHvAFVRiFIRT2SaijXF4iUNgMsMRkGs0kHJjdl+cTFTSs
         f0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ktzdl5eoKPEHfEuFryFzhZR7Y8sf35Stxv0I9TC3om8=;
        b=H92uZ2sDtcAXKtlub8cNLOervVpyex+Y7EYoohOSGcyzoBSuK8mo0qScZl6prk+iop
         Gnr9YexAnKSCQp2M4WiWH+X6isyoXFt12V2QRBQf7oKBiQJbBKdN8oMdsOyOGCLp7+Hv
         tTeWQ9Pq5IAjk1nvUvESooMbHZVYKzIhtWNS0HH7k3FdNPyKajC4SJJcm8EZ6Uky1uMu
         ry0V+Wpp4Seg0U7N51x+ffSaucKzI9ZL0ODJdgaWhe5sD+iUxv0p6Nc+k1ua0ftiJocp
         qyqSWR6IT9w0dal3w/z9erIh1mtWmtLZo54ldWWQSiTx6XOJmxh/FihO8L2inDTJYXtF
         s8zw==
X-Gm-Message-State: ANhLgQ39m+1vlbF4fvXM1UWnVwF3bh9lpt5//fu3uzPLnSK72BT8j/BM
        D06UIJ+bd0zyqq6R7xE3SbWwVR8tB6+hEjyR0i3KRQ==
X-Google-Smtp-Source: ADFU+vt5Eu/0Gf/mJjQWTqW8ukh7kOFSPWFoB1kOcBU0Lbg1MDkcSsM3OxPy3w+OIQUMQkvfoeEVgnNZxUT2k13A3Vg=
X-Received: by 2002:ab0:6605:: with SMTP id r5mr363174uam.0.1582836893873;
 Thu, 27 Feb 2020 12:54:53 -0800 (PST)
MIME-Version: 1.0
References: <1581434955-11087-1-git-send-email-vbadigan@codeaurora.org> <1582545470-11530-1-git-send-email-vbadigan@codeaurora.org>
In-Reply-To: <1582545470-11530-1-git-send-email-vbadigan@codeaurora.org>
From:   Doug Anderson <dianders@google.com>
Date:   Thu, 27 Feb 2020 12:54:41 -0800
Message-ID: <CAD=FV=WjSC7h0Q1aQpF74KDpgjOPSKrUR5gBo1ZsFn_o4m5TyQ@mail.gmail.com>
Subject: Re: [PATCH V3] dt-bindings: mmc: sdhci-msm: Add CQE reg map
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>, cang@codeaurora.org,
        Ram Prakash Gupta <rampraka@codeaurora.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Mon, Feb 24, 2020 at 3:58 AM Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> CQE feature has been enabled on sdhci-msm. Add CQE reg map
> and reg names that need to be supplied for supporting CQE feature.
>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> ---
> Changes since V2:
>         - Dropped _mem suffix to reg names.
>
> Changes since V1:
>         - Updated description for more clarity & Fixed typos.
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I assume you'll have a follow-up fixing the driver since commit
a4080225f51d ("mmc: cqhci: support for command queue enabled host")
refers to "cqhci_mem".


Also something to keep in mind for future patches (no action needed
for this patch): most maintainers frown on making v2 of a patch
"In-Reply-To" v1 of a patch.  I notice that your v3 was in-reply-to v2
and v2 was in-reply-to v1.  You probably don't want to do this.  One
such reference to people not liking it [1] specifically said "they
should not be replies to old versions of that patch; otherwise the
threading looks really weird and confusing."

[1] https://lore.kernel.org/r/CAJWu+oocs3T8orMNt6AmdVgWONzZg0vD=E8EdvzE9rOi_XatUw@mail.gmail.com


-Doug
