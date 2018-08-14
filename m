From: Rob Herring <robh@kernel.org>
Subject: Re: [v0.1 PATCH 3/7] dt-bindings: mmc: add DT binding for UniPhier
 SD/eMMC controller
Date: Tue, 14 Aug 2018 14:15:02 -0600
Message-ID: <20180814201502.GA26094@rob-hp-laptop>
References: <1533622642-13989-1-git-send-email-yamada.masahiro@socionext.com>
 <1533622642-13989-4-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533622642-13989-4-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-renesas-soc@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Jassi Brar <jaswinder.singh@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Tue,  7 Aug 2018 15:17:18 +0900, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> This SD/eMMC controller is used for UniPhier SoC family.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  .../devicetree/bindings/mmc/uniphier-sd.txt        | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/uniphier-sd.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
