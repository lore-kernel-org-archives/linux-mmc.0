From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: debugfs: add runtime pm when cat ios or clock file node
Date: Mon, 24 Apr 2017 10:12:13 +0200
Message-ID: <CAPDyKFpgVCX3+Xz=1264m2bL9=GOndzfY3N=21y8tErbWuv6pw@mail.gmail.com>
References: <1493017393-13785-1-git-send-email-haibo.chen@nxp.com> <d3a75424-1ae6-cbc6-ca1e-72a2768bf2ad@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:34475 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1166466AbdDXIMO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Apr 2017 04:12:14 -0400
Received: by mail-qt0-f182.google.com with SMTP id c45so107106203qtb.1
        for <linux-mmc@vger.kernel.org>; Mon, 24 Apr 2017 01:12:14 -0700 (PDT)
In-Reply-To: <d3a75424-1ae6-cbc6-ca1e-72a2768bf2ad@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Haibo Chen <haibo.chen@nxp.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Aisheng Dong <aisheng.dong@nxp.com>

On 24 April 2017 at 09:16, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 24/04/17 10:03, Haibo Chen wrote:
>> MMC core code add 'MMC_CAP_RUNTIME_RESUME', postpone the real card
>> resume operation from bus_resume to bus_runtime_resume. So after
>> system resume, for non-removable-card, it still not really resume.
>> At this point, if user cat the ios or clock node, only can get zero
>> data although the mmc/sd card is still present.
>
> If you ask me, getting zero is correct.

I fully agree!

The job for the debugfs ios node, is to report the current state, not
to change it.

[...]

Kind regards
Uffe
