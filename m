From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: debugfs: add runtime pm when cat ios or clock file node
Date: Mon, 24 Apr 2017 11:47:56 +0200
Message-ID: <CAPDyKFoRqWCjHf2iTxXGYUBgdVhPiVnSEMRyd90fFu-N05fP=A@mail.gmail.com>
References: <1493017393-13785-1-git-send-email-haibo.chen@nxp.com>
 <d3a75424-1ae6-cbc6-ca1e-72a2768bf2ad@intel.com> <CAPDyKFpgVCX3+Xz=1264m2bL9=GOndzfY3N=21y8tErbWuv6pw@mail.gmail.com>
 <AM4PR0401MB2324F931188A9FA2A144623D901F0@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33732 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1168034AbdDXJr5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Apr 2017 05:47:57 -0400
Received: by mail-qk0-f176.google.com with SMTP id h123so26720433qke.0
        for <linux-mmc@vger.kernel.org>; Mon, 24 Apr 2017 02:47:57 -0700 (PDT)
In-Reply-To: <AM4PR0401MB2324F931188A9FA2A144623D901F0@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bough Chen <haibo.chen@nxp.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "A.S. Dong" <aisheng.dong@nxp.com>

On 24 April 2017 at 11:06, Bough Chen <haibo.chen@nxp.com> wrote:
>> -----Original Message-----
>> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
>> Sent: Monday, April 24, 2017 4:12 PM
>> To: Adrian Hunter <adrian.hunter@intel.com>; Bough Chen
>> <haibo.chen@nxp.com>
>> Cc: linux-mmc@vger.kernel.org; A.S. Dong <aisheng.dong@nxp.com>
>> Subject: Re: [PATCH] mmc: debugfs: add runtime pm when cat ios or clock =
file
>> node
>>
>> On 24 April 2017 at 09:16, Adrian Hunter <adrian.hunter@intel.com> wrote=
:
>> > On 24/04/17 10:03, Haibo Chen wrote:
>> >> MMC core code add 'MMC_CAP_RUNTIME_RESUME', postpone the real
>> card
>> >> resume operation from bus_resume to bus_runtime_resume. So after
>> >> system resume, for non-removable-card, it still not really resume.
>> >> At this point, if user cat the ios or clock node, only can get zero
>> >> data although the mmc/sd card is still present.
>> >
>> > If you ask me, getting zero is correct.
>>
>> I fully agree!
>>
>> The job for the debugfs ios node, is to report the current state, not to=
 change it.
>
> Got it.
>
> I have one more question: take sdhci and sdhci-esdhc-imx as example, if c=
ontroller in runtime suspend,  then cat the ios, we will see the value incl=
uding clock, but in sdhci-esdhc-imx, we already disable the usdhc clock in =
runtime suspend, the two are not match, I'm confused of this.

Correct. The main purpose of the debugfs ios node is to provide
information about the current operation conditions for the card and
not really for the host. I can see it is a bit confusing, however
that's how it has been a very long long time.

If you need to know about current operation conditions for the host,
those needs to be implemented in the host driver. Typical information
could be a register dump of the controller.

Kind regards
Uffe
