From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mmc: fsl-imx-esdhc: add imx6ull
 compatible string
Date: Fri, 28 Dec 2018 16:09:53 -0200
Message-ID: <CAOMZO5BeUA2YwzH2Vme4xmpwiciX5xRmCqxA_-=VAV7zPmeQdw@mail.gmail.com>
References: <20181228033323.32308-1-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181228033323.32308-1-haibo.chen@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: BOUGH CHEN <haibo.chen@nxp.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>, "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi Bough,

On Fri, Dec 28, 2018 at 1:26 AM BOUGH CHEN <haibo.chen@nxp.com> wrote:
>
> Add imx6ull compatible string

Please explain the reason, like you did in the other commit log that
explains the need for handling erratum ERR010450 on i.MX6ULL.
