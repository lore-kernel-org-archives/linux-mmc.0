From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: dt: Consolidate DT bindings
Date: Sun, 13 May 2012 16:10:43 -0400
Message-ID: <87pqa7suyk.fsf@laptop.org>
References: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org>
	<4F75D5C0.5050307@wwwdotorg.org> <871umou38f.fsf_-_@laptop.org>
	<201205131946.33109.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <201205131946.33109.arnd@arndb.de> (Arnd Bergmann's message of
	"Sun, 13 May 2012 19:46:32 +0000")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Viresh Kumar <viresh.kumar@st.com>, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, rob.herring@calxeda.com, Anton Vorontsov <anton.vorontsov@linaro.org>, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, kgene.kim@samsung.com, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Arnd,

On Sun, May 13 2012, Arnd Bergmann wrote:
> I've verified that there are no conflicts with anything we have in
> arm-soc right now, so I think it should just go through your
> tree.

Ah, I based the patch on latest linux-next.  That's why there aren't
conflicts against arm-soc, but there are conflicts (in the omap and
tegra dts changes) between the patch and Linus master/mmc-next:

Applying: mmc: dt: Consolidate DT bindings
error: patch failed: arch/arm/boot/dts/omap3-beagle.dts:57
error: patch failed: arch/arm/boot/dts/omap4-panda.dts:55
error: patch failed: arch/arm/boot/dts/omap4-sdp.dts:94
error: patch failed: arch/arm/boot/dts/tegra-cardhu.dts:141
error: patch failed: arch/arm/boot/dts/tegra-harmony.dts:335
error: patch failed: arch/arm/boot/dts/tegra-ventana.dts:338
Patch failed at 0001 mmc: dt: Consolidate DT bindings

So I think merging via arm-soc is the only way to get it to Linus
without conflicts.  (Alternatively I can take it in mmc-next and
Linus can handle the conflicts.)

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
