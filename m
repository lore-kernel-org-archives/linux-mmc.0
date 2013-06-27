From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 2/2] mmc: dw_mmc: Add the ability to set the ciu clock frequency
Date: Thu, 27 Jun 2013 11:36:11 -0400
Message-ID: <87obaro9as.fsf@octavius.laptop.org>
References: <1370580406-10254-1-git-send-email-dianders@chromium.org>
	<1370626110-1731-1-git-send-email-dianders@chromium.org>
	<1370626110-1731-2-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1370626110-1731-2-git-send-email-dianders@chromium.org> (Doug
	Anderson's message of "Fri, 7 Jun 2013 10:28:30 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Olof Johansson <olof@lixom.net>, Andrew Bresticker <abrestic@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Will Newton <will.newton@gmail.com>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Doug,

On Fri, Jun 07 2013, Doug Anderson wrote:
> As of now we rely on code outside of the driver to set the ciu clock
> frequency.  There's no reason to do that.  Add support for setting up
> the clock in the driver during probe.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
> Changes in v2:
> - Added example as per Jaehoon.

Thanks, pushed to mmc-next for 3.11.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
