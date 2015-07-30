From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] DT: mmc: sh_mmcif: fix "compatible" property text
Date: Thu, 30 Jul 2015 23:33:04 +0300
Message-ID: <55BA8A00.9090703@cogentembedded.com>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
 <3979266.lQrOKbu0yo@wasted.cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <3979266.lQrOKbu0yo@wasted.cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hello.

On 07/30/2015 10:59 PM, Sergei Shtylyov wrote:

> The "compatible" property text contradicts even the example given in the MMCIF
> binding document itself; moreover, the Renesas MMCIF driver only  matches  on
> the generic "compatible" string, and doesn't look for at SoC specific strings

    "For" not needed here.

> currently at all. Thus describe "renesas,sh-mmcif" string as mandatory and the
> others as optional.

> Fixes: b4c27763d749 ("mmc: sh_mmcif: Document DT bindings")
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

    Do I need to repost?

MBR, Sergei

