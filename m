From: Piotr Sroka <piotrs@cadence.com>
Subject: RE: [v5 2/4] dt-bindings: mmc: add description of PHY delays for sdhci-cadence
Date: Thu, 30 Mar 2017 12:06:36 +0100
Message-ID: <201703301106.v2UB6aj4001807@lvloginb.cadence.com>
References: <1490106736-2242-1-git-send-email-piotrs@cadence.com>
 <1490106781-3129-1-git-send-email-piotrs@cadence.com>
 <CAK7LNAS+=KjuD-31he5fRw=S_t10Uygae7bOWf+uRYVCPeW=5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK7LNAS+=KjuD-31he5fRw=S_t10Uygae7bOWf+uRYVCPeW=5w@mail.gmail.com> 
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Piotr <piotrs@cadence.com>
List-Id: linux-mmc@vger.kernel.org

Hi Masahiro

2017-03-22 16:30  Masahiro Yamada <yamada.masahiro@socionext.com>:
> 2017-03-21 23:33 GMT+09:00 Piotr Sroka <piotrs@cadence.com>:
> > DTS properties are used instead of fixed data
> > because PHY settings can be different for different chips/boards.
> > Add description of new DLL PHY delays.
> >
> > Signed-off-by: Piotr Sroka <piotrs@cadence.com>
> > ---
> > Changes for v2:
> > - file was created in v2. It was a part of driver source file patch.
> > - most delays were moved from dts file
> >   to data associated with an SoC specific compatible
> > - description of delays was updated to be more clearly
> > ---
> > Changes for v3:
> > - move all delays back to dts because they are also boards dependent
> > - prefix all of the Cadence-specific properties with cdns prefix
> > ---
> > Changes for v4:
> > - change the beginning of the commit subject
> > ---
> > Changes for v5:
> > - change name of property to be consistent with timing modes
> >   available in Linux
> 
> 
> As I gave Reviewed-by in v4 already, this looks good to me.
> 
> 
> Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> 
> 
> As I said before,
> once you get Reviewed/Acked tags,
> please include them in your later version.
> 

Ok. I will remember next time.

-- 
Best Regards
Piotr Sroka
