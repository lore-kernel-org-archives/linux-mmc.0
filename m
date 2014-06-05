From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Jun 5 (mmc/host/usdhi6ro10.c)
Date: Thu, 05 Jun 2014 10:07:24 -0700
Message-ID: <5390A3CC.2020309@infradead.org>
References: <20140605192853.0344d9d3@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140605192853.0344d9d3@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-mmc@vger.kernel.org

On 06/05/2014 02:28 AM, Stephen Rothwell wrote:
> Hi all,
> 
> The powerpc allyesconfig is again broken more than usual.
> 
> Our build server is down today, so this linux-next will not get the
> usual builds done, sorry.
> 
> Changes since 20140604:
> 
> 
> The mmc tree lost its build failure.

but has a bunch of printk format warnings on x86_64:


../drivers/mmc/host/usdhi6rol0.c:359:2: warning: format '%zd' expects argument of type 'signed size_t', but argument 4 has type 'unsigned int' [-Wformat]
../drivers/mmc/host/usdhi6rol0.c:359:2: warning: format '%zd' expects argument of type 'signed size_t', but argument 5 has type 'unsigned int' [-Wformat]
../drivers/mmc/host/usdhi6rol0.c:462:2: warning: format '%u' expects argument of type 'unsigned int', but argument 7 has type 'size_t' [-Wformat]
../drivers/mmc/host/usdhi6rol0.c:491:3: warning: format '%zd' expects argument of type 'signed size_t', but argument 4 has type 'unsigned int' [-Wformat]
../drivers/mmc/host/usdhi6rol0.c:491:3: warning: format '%zd' expects argument of type 'signed size_t', but argument 5 has type 'unsigned int' [-Wformat]
../drivers/mmc/host/usdhi6rol0.c:898:2: warning: format '%x' expects argument of type 'unsigned int', but argument 9 has type 'size_t' [-Wformat]
../drivers/mmc/host/usdhi6rol0.c:1668:3: warning: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'size_t' [-Wformat]


-- 
~Randy
