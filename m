From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: rename DTRAN_MODE_BUS_WID_TH to
 DTRAN_MODE_BUS_WIDTH
Date: Wed, 3 Oct 2018 18:48:48 +0300
Message-ID: <c45bd9f9-23da-4802-8918-fec5efebc6d6@cogentembedded.com>
References: <1538566780-30794-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538566780-30794-1-git-send-email-yamada.masahiro@socionext.com>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 10/03/2018 02:39 PM, Masahiro Yamada wrote:

> Socionext UniPhier SoCs use the almost the same internal DMAC.
> My datasheet says 'BUS_WIDTH' instead of 'BUS_WID_TH'.  I suspect
> this is a typo.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

   Already fixed, see:

https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/commit/?h=devel&id=652c517c6828a830b71db4b1439a0229c98d9b9e

MBR, Sergei
