From: Maxime Coquelin <maxime.coquelin@st.com>
Subject: Re: [PATCH v2 2/8] mmc: sdhci-st: Add support for de-asserting reset
 signal and top regs resource
Date: Tue, 3 Mar 2015 11:34:15 +0100
Message-ID: <54F58E27.10401@st.com>
References: <1424956227-18258-1-git-send-email-peter.griffin@linaro.org> <1424956227-18258-3-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424956227-18258-3-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, chris@printf.net, ulf.hansson@linaro.org
Cc: lee.jones@linaro.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, peppe.cavallaro@st.com
List-Id: linux-mmc@vger.kernel.org

Hi Peter,

On 02/26/2015 02:10 PM, Peter Griffin wrote:
> STiH407 family SoC's can have a reset signal for the controller which needs to
> be managed. Also the eMMC controller has some additional 'top' memory mapped
> registers which are used to manage the dynamic and static delay required for
> UHS modes. This patch adds support for creating the mapping, which will be used
> by subsequent patches.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> ---
>   drivers/mmc/host/sdhci-st.c | 52 ++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 49 insertions(+), 3 deletions(-)
>

Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks,
Maxime
