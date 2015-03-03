From: Maxime Coquelin <maxime.coquelin@st.com>
Subject: Re: [PATCH v2 7/8] mmc: sdhci-st: Update ST SDHCI binding documentation.
Date: Tue, 3 Mar 2015 12:01:48 +0100
Message-ID: <54F5949C.4050505@st.com>
References: <1424956227-18258-1-git-send-email-peter.griffin@linaro.org> <1424956227-18258-8-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424956227-18258-8-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, chris@printf.net, ulf.hansson@linaro.org
Cc: lee.jones@linaro.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, peppe.cavallaro@st.com
List-Id: linux-mmc@vger.kernel.org


On 02/26/2015 02:10 PM, Peter Griffin wrote:
> This patch updates the binding information to reflect the
> extra dt options which are now supported by the sdhci-st.c
> driver which enable support for stih407 family silicon.
>
> Stih410 SoC and later support UHS modes for eMMC, so the
STiH410
> driver now makes use of these common bindings. Examples
> are provided for both eMMC (which has additional bindings)
> and also sd slot for stih407.
STiH407
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>   Documentation/devicetree/bindings/mmc/sdhci-st.txt | 100 ++++++++++++++++++---
>   1 file changed, 90 insertions(+), 10 deletions(-)
>

Once fixed, you can add my:
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks,
Maxime
