From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/7] mmc: dw_mmc: lookup for optional biu and ciu clocks
Date: Thu, 10 May 2012 14:43:42 +0100
Message-ID: <20120510134342.GA12727@n2100.arm.linux.org.uk>
References: <1335935266-25289-1-git-send-email-thomas.abraham@linaro.org> <1335935266-25289-2-git-send-email-thomas.abraham@linaro.org> <CAAG0J9-NDM9wLKpq04ofPkvFqiWxjmP84ojsP9Hfs0SJ_0FaXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAG0J9-NDM9wLKpq04ofPkvFqiWxjmP84ojsP9Hfs0SJ_0FaXg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: James Hogan <james@albanarts.com>
Cc: Thomas Abraham <thomas.abraham@linaro.org>, linux-samsung-soc@vger.kernel.org, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, kgene.kim@samsung.com, cjb@laptop.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Wed, May 02, 2012 at 03:53:53PM +0100, James Hogan wrote:
> Hi
>=20
> On 2 May 2012 06:07, Thomas Abraham <thomas.abraham@linaro.org> wrote=
:
> > + =A0 =A0 =A0 if (IS_ERR(host->biu_clk))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&host->dev, "biu clock not a=
vailable\n");
>=20
> In this case, should it set host->biu_clk to NULL or are clk_disable
> and clk_put guaranteed to handle an IS_ERR value?

I keep saying this.  NULL must be treated as a valid reutrn value from
clk_get() and must not use this as a sentinel.  The clk namespace is
that errors are indicated with IS_ERR(clk) returning true.  Everything
else must be assumed to be valid by drivers.
