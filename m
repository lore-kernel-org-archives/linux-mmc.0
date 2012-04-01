From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3 0/6] mmc: sdhci-s3c: Rework platform data and add device tree support
Date: Sat, 31 Mar 2012 21:12:39 -0400
Message-ID: <87zkawmf08.fsf@laptop.org>
References: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org>
	<003401cce730$baf979a0$30ec6ce0$%kim@samsung.com>
	<m2aa4pkq5g.fsf@bob.laptop.org> <4F3CFEED.6060206@samsung.com>
	<m239abgc32.fsf@bob.laptop.org>
	<00b901ccf08d$2fc18b50$8f44a1f0$%kim@samsung.com>
	<m2vcn0496y.fsf@bob.laptop.org> <87k426vy9r.fsf@laptop.org>
	<20120328095450.GA23005@sirena.org.uk> <4F73D3D7.1010202@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <4F73D3D7.1010202@samsung.com> (Kukjin Kim's message of "Wed, 28
	Mar 2012 20:15:35 -0700")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-samsung-soc@vger.kernel.org, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, 'Thomas Abraham' <thomas.abraham@linaro.org>, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org, 'Olof Johansson' <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-mmc@vger.kernel.org

Hi Kukjin,

On Wed, Mar 28 2012, Kukjin Kim wrote:
>>> As a result I'm dropping this tree -- and all of the patches that I
>>> have on top of it -- from mmc-next so that I can get a pull request
>>> out.  This means that I'm dropping:
>>
> Hmm, I think, if you're ok, you can send a second pull request to
> Linus for it and actually, it is in linux-next for a long time via mmc
> and samsung tree.
>
> Note, please don't rebase it because its resolution for conflicts is
> in linux-next and I think Linus will use it when happens
> conflicts...Or I can provide new tree on top of latest mainline. But
> I'm not sure about latter.

I can't send the tree as it is to Linus now, because Arnd has asked us
to hold off on these device tree bindings and work with the unified
bindings he's proposing instead.  (Rebasing to drop that patch will
introduce new conflicts.)

I'm going to send Mark Brown's two patches to Linus now, even though it
will cause a conflict in -next.  The rest (other than the device tree
bindings) are mergable after -rc1, because they're fixes, so we'll
eventually get everything except DT in to 3.4.  I think you should
just drop this patchset from your tree in linux-next entirely now.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
