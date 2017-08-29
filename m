From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 3/5] dt-bindings: sdhci-omap: Add bindings for the
 sdhci-omap controller
Date: Tue, 29 Aug 2017 07:43:38 -0700
Message-ID: <20170829144338.GY6008@atomide.com>
References: <20170821142132.GH6008@atomide.com>
 <20170823054246.23927-1-kishon@ti.com>
 <CAPDyKFp7gchVQ+JPNqv4LktvHRm2Lzx6KakOw85zEZxDEX0OhA@mail.gmail.com>
 <c9342689-f09e-44af-0975-d43ef122a477@ti.com>
 <CAPDyKFqCZFM7UmHyQCm=DwwZXJvzUde3pW0HqARKrsgfgxSuaw@mail.gmail.com>
 <0c7e0705-d9c2-4499-54ba-cbd84589dc01@ti.com>
 <20170829115050.3axlr5uysmqlhvd2@earth>
 <20170829135822.GR6008@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170829135822.GR6008@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, Ravikumar Kattekola <rk@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [170829 06:58]:
> It's best to enable devices to use the new compatible as things are
> tested rather than hope for some magic "flag day" flip that might
> never happen. Having two days attempting to probe with the same
> binding just won't work.

Hehe I mean "Having two drivers attempting to probe with the same
binding" above.

Tony
