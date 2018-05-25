From: Vinod <vkoul@kernel.org>
Subject: Re: [PATCH v2 11/13] dmaengine: pxa: make the filter function
 internal
Date: Fri, 25 May 2018 16:29:43 +0530
Message-ID: <20180525105943.GP26663@vkoul-mobl>
References: <20180524070703.11901-1-robert.jarzmik@free.fr>
 <20180524070703.11901-12-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180524070703.11901-12-robert.jarzmik@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, dmaengine@vger.kernel.org, linux-media@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, netdev@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-mmc@vger.kernel.org

On 24-05-18, 09:07, Robert Jarzmik wrote:
> As the pxa architecture and all its related drivers do not rely anymore
> on the filter function, thanks to the slave map conversion, make
> pxad_filter_fn() static, and remove it from the global namespace.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
