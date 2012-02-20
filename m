From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] Documentation/gpio.txt: Explain expected pinctrl
	interaction
Date: Mon, 20 Feb 2012 07:39:41 +0000
Message-ID: <20120220073941.GC22562@n2100.arm.linux.org.uk>
References: <1329719263-18971-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1329719263-18971-1-git-send-email-swarren@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: Stephen Warren <swarren@nvidia.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>, Randy Dunlap <rdunlap@xenotime.net>, Olof Johansson <olof@lixom.net>, Colin Cross <ccross@android.com>, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Sun, Feb 19, 2012 at 11:27:42PM -0700, Stephen Warren wrote:
> Update gpio.txt based on recent discussions regarding interaction with the
> pinctrl subsystem.
> 
> Previously, gpio_request() was described as explicitly not performing any
> required mux setup operations etc.
> 
> Now, gpio_request() is explicitly as explicitly performing any required mux
> setup operations where possible. In the case it isn't, platform code is
> required to have set up any required muxing or other configuration prior to
> gpio_request() being called, in order to maintain the same semantics.

So what if you need to have the pin as a GPIO, manipulate it as a GPIO,
and then hand it off to a special function, and then take it back as
a GPIO before you shut the special function down ?
