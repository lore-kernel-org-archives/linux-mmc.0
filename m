From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-omap: Workaround errata regarding SDR104/HS200
 tuning failures (i929)
Date: Mon, 10 Dec 2018 17:56:36 +0100
Message-ID: <CAPDyKFou7hSELknyOV-eP+6ROJozwc-7vPBy2Rkb7hSdL37Pqg@mail.gmail.com>
References: <20181129190503.6040-1-faiz_abbas@ti.com> <cb1e8e88-4c9d-741d-79cd-57b03c5e0808@ti.com>
 <c4704766-7a58-8aa4-6bc0-b9373b15096c@ti.com> <CAPDyKFqMW+tMaVsS_c=kPztZRjX97Nzr2W0egvDkyzkpWckHRA@mail.gmail.com>
 <d1ae4e93-4b17-9574-00b1-bfa268cb7574@ti.com> <CAPDyKFrLzEfGKkC3K9znjJUKO1MUjdBpaL0HEtHYOzbAgNO-fg@mail.gmail.com>
 <e19a5c39-028e-8dda-aa0a-3968a213cd47@ti.com> <CAPDyKFoO7tn1Xdu9ROqRVjZ1SZnzXcxduB97OQtmz2d2E_epUQ@mail.gmail.com>
 <218be2af-8f81-47b4-f782-b774e10642c1@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <218be2af-8f81-47b4-f782-b774e10642c1@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: Kishon <kishon@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, 10 Dec 2018 at 17:43, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Hi,
>
> On 10/12/18 8:55 PM, Ulf Hansson wrote:
> > On Mon, 10 Dec 2018 at 15:04, Faiz Abbas <faiz_abbas@ti.com> wrote:
> >>
> >> Hi,
> >>
> >> On 10/12/18 7:15 PM, Ulf Hansson wrote:
> >>> On Mon, 10 Dec 2018 at 14:23, Faiz Abbas <faiz_abbas@ti.com> wrote:
> >>>>
> >>>> Hi Uffe,
> >>>>
> >>>> On 05/12/18 7:20 PM, Ulf Hansson wrote:
> >>>>> On Fri, 30 Nov 2018 at 06:53, Faiz Abbas <faiz_abbas@ti.com> wrote:
> >>>>>>
> >>>>>> Hi Kishon,
> >>>>>>
> >>>>>> On 30/11/18 10:10 AM, Kishon Vijay Abraham I wrote:
> >>>>>>> Hi Faiz,
> >>>>>>>
> >>>>>>> On 30/11/18 12:35 AM, Faiz Abbas wrote:
> >>>>>>>> Errata i929 in certain OMAP5/DRA7XX/AM57XX silicon revisions
> >>>>>>>> (SPRZ426D - November 2014 - Revised February 2018 [1]) mentions
> >>>>>>>> unexpected tuning pattern errors. A small failure band may be present
> >>>>>>>> in the tuning range which may be missed by the current algorithm.
> >>>>>>>> Furthermore, the failure bands vary with temperature leading to
> >>>>>>>> different optimum tuning values for different temperatures.
> >>>>>>>>
> >>>>>>>> As suggested in the related Application Report (SPRACA9B - October 2017
> >>>>>>>> - Revised July 2018 [2]), tuning should be done in two stages.
> >>>>>>>> In stage 1, assign the optimum ratio in the maximum pass window for the
> >>>>>>>> current temperature. In stage 2, if the chosen value is close to the
> >>>>>>>> small failure band, move away from it in the appropriate direction.
> >>>>>>>>
> >>>>>>>> References:
> >>>>>>>> [1] http://www.ti.com/lit/pdf/sprz426
> >>>>>>>> [2] http://www.ti.com/lit/pdf/SPRACA9
> >>>>>>>>
> >>>>>>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> >>>>>>>> ---
> >> ...
> >>>>>>>
> >>>>>>> Can't we get thermal zone once during probe?
> >>>>>>>
> >>>>>>
> >>>>>> Tuning is also (ideally) supposed to happen only once per enumeration.
> >>>>>> Also it doesn't make sense to get a thermal zone for lower speed systems
> >>>>>> that won't do tuning.
> >>>>>
> >>>>> Currently sdhci-omap calls pm_runtime_get_sync() during probe, and
> >>>>> then keeps the host device runtime resumed until ->remove() is called
> >>>>> on it. I assume you are going to change that, at some point!?
> >>>>>
> >>>>> In other words, what will happen to the host device when it becomes
> >>>>> runtime suspended? Is re-tuning needed when it gets runtime resumed,
> >>>>> which is the case for many other sdhci variants?
> >>>>
> >>>> There are no plans to support runtime_suspend()/resume() any time in the
> >>>> near future. If its ok with you, I would like to get this patch in
> >>>> without any changes. We can change it in case a need for
> >>>> runtime_suspend()/_resume() does arise.
> >>>
> >>> Right, I am okay with that. Due to recent changes to sdhci-omap
> >>> $subject patch doesn't apply, can you please rebase!?
> >>>
> >>> Additionally, I realized that we should fold in patch updating the DT
> >>> doc for sdhci-omap, adding the property for the thermal zone. I
> >>> regards to that, I am wondering if "cpu_thermal", is really the
> >>> correct name of the zone. The point is, I am guessing the zone could
> >>> change along with the SoCs/platforms.
> >>>
> >>
> >> As you have probably noticed, we are introducing a new driver
> >> (sdhci_am654) for newer platforms. I don't foresee using sdhci-omap
> >> driver with any other platforms. In case we do use it, we can add the dt
> >> property at that point of time and default to "cpu_thermal" to maintain
> >> dt compatibility.
> >>
> >> Will rebase and send v2 if you are ok with above.
> >
> > I see, but you still need to update the DT doc for sdhci-omap.
> >
>
> I didn't get you. There are no changes in dt. What changes should I
> document?

Well, you are fetching a thermal zone using a specific name. It's
quite similar to how we document other resources (pinctrls for
example) that sdhci omap depends on, so that needs to be document too.

Kind regards
Uffe
