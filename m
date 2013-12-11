From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] clk: hisilicon: add hi3620_mmc_clks
Date: Wed, 11 Dec 2013 15:44:47 +0100
Message-ID: <201312111544.47519.arnd@arndb.de>
References: <1386770541-15056-1-git-send-email-zhangfei.gao@linaro.org>
 <1386770541-15056-4-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1386770541-15056-4-git-send-email-zhangfei.gao@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: devicetree@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, patches@linaro.org, Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Kumar Gala <galak@codeaurora.org>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Wednesday 11 December 2013, Zhangfei Gao wrote:
> +PCTRL: Peripheral misc control register
> +
> +Required Properties:
> +- compatible: "hisilicon,pctrl"
> +- reg: Address and size of pctrl.
> +
> +Example:
> +
> +       /* for Hi3620 */
> +       pctrl: pctrl@fca09000 {
> +               compatible = "hisilicon,pctrl";
> +               reg = <0xfca09000 0x1000>;
> +       };

It seems you are missing the clock specific parts of the binding:
You should document the required value of #clock-cells as well as
the possible values for the clock specifier.

	Arnd
