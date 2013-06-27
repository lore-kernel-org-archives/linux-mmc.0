From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 1/2] mmc: dw_mmc: Handle late vmmc regulators with EPROBE_DEFER
Date: Thu, 27 Jun 2013 11:34:39 -0400
Message-ID: <87vc4zo9dc.fsf@octavius.laptop.org>
References: <1370580406-10254-1-git-send-email-dianders@chromium.org>
	<1370626110-1731-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1370626110-1731-1-git-send-email-dianders@chromium.org> (Doug
	Anderson's message of "Fri, 7 Jun 2013 10:28:29 -0700")
Sender: linux-doc-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Olof Johansson <olof@lixom.net>, Andrew Bresticker <abrestic@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Will Newton <will.newton@gmail.com>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Doug,

On Fri, Jun 07 2013, Doug Anderson wrote:
> It is possible to specify a regulator that should be turned on when
> dw_mmc is probed.  At the moment dw_mmc will fail to use the regulator
> properly if the regulator probes after dw_mmc.  Fix this problem by
> honoring EPROBE_DEFER.
>
> At the same time move the regulator code out of the slot init code.
> We only specify one regulator for the whole device and other parts of
> the code (like suspend/resume) assume that the regulator has only been
> enabled once.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
> Changes in v2:
> - Avoid hackery to detect regulators that will never show up.
> - Move regulator out of slot init--it doesn't belong there.

Thanks, pushed to mmc-next for 3.11.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
