From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 1/2] mmc: add Device Tree properties for UHS modes
Date: Fri, 26 Jul 2013 11:10:58 -0600
Message-ID: <51F2ADA2.2030503@wwwdotorg.org>
References: <Pine.LNX.4.64.1307261747210.22137@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1307261747210.22137@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>, Ian Campbell <ian.campbell@citrix.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Rob Herring <rob.herring@calxeda.com>
List-Id: linux-mmc@vger.kernel.org

On 07/26/2013 09:51 AM, Guennadi Liakhovetski wrote:
> Add DT properties for UHS SDR12, SDR25, SDR50, SDR104 and DDR50 modes and
> for supported by the host in DDR mode VccQ values. Adding them to DT will
> automatically enable respective MMC host capabilities.

> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt

> +- uhs-sdr12: the host supports UHS SDR12 mode
> +- uhs-sdr25: the host supports UHS SDR25 mode
> +- uhs-sdr50: the host supports UHS SDR50 mode
> +- uhs-sdr104: the host supports UHS SDR104 mode
> +- uhs-ddr50: the host supports UHS DDR50 mode
> +- ddr-1v2: the host can support DDR, using 1.2V VccQ
> +- ddr-1v8: the host can support DDR, using 1.8V VccQ

Surely the driver for the host controller already knows this, so there's
no need to represent it in DT?
