From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 6/6] mmc: sdhci-s3c: Add device tree support
Date: Tue, 27 Mar 2012 16:19:13 +0000
Message-ID: <201203271619.13320.arnd@arndb.de>
References: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org> <1328032576-9269-7-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1328032576-9269-7-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>, Lee Jones <lee.jones@linaro.org>, Viresh Kumar <viresh.kumar@st.com>, Rajendra Nayak <rnayak@ti.com>, Stephen Warren <swarren@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Anton Vorontsov <anton.vorontsov@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

On Tuesday 31 January 2012, Thomas Abraham wrote:
> +
> +Optional Board Specific Properties:
> +- samsung,sdhci-bus-width: Number of data lines connected to the controller.
> +  Note: This excludes the clock,command and card detect lines. If this property
> +  is not specified, default value is 1.
> +
> +- samsung,cd-gpio-invert: If 'samsung,sdhci-cd-gpio' card detect method is
> +  selected, this property can be optionally specified to invert the value of
> +  external card detect gpio line.
> +
> +- One of the following properties for card detect type.
> +  - samsung,sdhci-cd-internal: Card detect line from the card slot  is
> +    connected to the card detect pad of the sdhci controller. A gpio is
> +    used for this connection (with possible pin function settings).
> +  - samsung,sdhci-cd-gpio: A gpio line (with possible pin function settings)
> +    is used a card detect line. This gpio line is not connected to card detect
> +    pad of the sdhci controller.
> +  - samsung,sdhci-cd-none: There is no card detect line. Polling is used to
> +    detect the presence of the card. (DEFAULT, if no card detect property
> +    is specified).
> +  - samsung,sdhci-cd-permanent: There is no card detect line. The card is
> +    permanently connected to the sdhci controller.
> +
> +- gpio-cd: The gpio to be used as card detect line for
> +  'samsung,sdhci-cd-internal' or 'samsung,sdhci-cd-gpio' card detection method.
> +  The gpio specifier format depends on the gpio controller.

These bindings came up in a discussion IRC today. I think it's rather bad that
we can't agree on a common way to name the properties for mmc. We have
bindings being proposed or already included from Anton, Stephen, Shawn,
Rajendra, Viresh, Lee and Thomas. Almost all of them define GPIO pins
for card detect and write protect, as well properties to define the bus
width and high-speed modes, but we seem to have almost as many different
definitions of these as we have drivers.

Can we please come up with a common binding for these?

	Arnd
