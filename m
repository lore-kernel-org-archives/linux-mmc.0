From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2] mmc: dt: Consolidate DT bindings
Date: Sun, 13 May 2012 19:46:32 +0000
Message-ID: <201205131946.33109.arnd@arndb.de>
References: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org>
 <4F75D5C0.5050307@wwwdotorg.org> <871umou38f.fsf_-_@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <871umou38f.fsf_-_-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, Anton Vorontsov <anton.vorontsov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Sunday 13 May 2012, Chris Ball wrote:
> On Fri, Mar 30 2012, Stephen Warren wrote:
> >> No progress so far. I would suggest we apply the patch below to unify
> >> the bindings we have. I tried to minimize the impact by picking the most
> >> common version for each property, but if we know about devices that would
> >> get broken by this, we may have to be more careful.
> >> 
> >> Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> 
> Here's a version of your MMC DT bindings patch that responds to Stephen
> Warren's review comments, refreshed against latest linux-next -- I'd
> like to get this merged for v3.5.  Since it touches many .dts files,
> should it go via arm-soc?  Thanks.

Hi Chris,

Sorry for not getting to this sooner myself and many thanks for your
taking it on!

I've verified that there are no conflicts with anything we have in
arm-soc right now, so I think it should just go through your
tree.

	Arnd
