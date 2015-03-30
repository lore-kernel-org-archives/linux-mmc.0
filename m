From: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/8] mmc: sdhci-st: Add macros for register offsets
 and bitfields for mmcss glue regs
Date: Mon, 30 Mar 2015 11:29:08 +0100
Message-ID: <20150330102908.GA21893@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1424956227-18258-1-git-send-email-peter.griffin@linaro.org>
 <1424956227-18258-2-git-send-email-peter.griffin@linaro.org>
 <54F58BED.4020900@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54F58BED.4020900-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peppe.cavallaro-qxv4g6HH51o@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Maxime,

On Tue, 03 Mar 2015, Maxime Coquelin wrote:

> >+
> >+#define	ST_MMC_CCONFIG_REG_1		0x400
> Maybe my mail client, but I see a tab instead of a space after #define.

Yes your correct, have fixed all occurances in v3

regards,

Peter.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
