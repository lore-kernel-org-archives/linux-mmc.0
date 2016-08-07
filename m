From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] dt: bindings: Add binding for ESP8089 wifi chips
Date: Sun, 07 Aug 2016 21:59:13 +0200
Message-ID: <2936779.FAiO1bqUWV@wuerfel>
References: <1470596269-20572-1-git-send-email-hdegoede@redhat.com>
 <1470596269-20572-2-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1470596269-20572-2-git-send-email-hdegoede@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: devicetree <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, Icenowy Zheng <icenowy@aosc.xyz>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Sunday, August 7, 2016 8:57:49 PM CEST Hans de Goede wrote:
> +Espressif ESP8089 wireless SDIO devices
> +
> +This node provides properties for controlling the ESP8089 wireless device.
> +The node is expected to be specified as a child node to the SDIO controller
> +that connects the device to the system.
> +
> +Required properties:
> +
> + - compatible : Should be "esp,esp8089".

I think it would be good to standardize a compatible string for sdio
like we have it for other discoverable buses, based on the
vendor/device ID (or whatever this uses), using something like

compatible = "sdio1234,5678", "esp,esp8089";

> +Optional properties:
> + - esp,crystal_26M_en: Integer value for the crystal_26M_en firmware parameter

better use '-' instead of '_' for property names.

	Arnd
