From: Christian Daudt <bcm@fixthebug.org>
Subject: Re: [PATCH v4 5/8] mmc: sdhci-bcm-kona: Add basic use of clocks
Date: Sat, 14 Dec 2013 00:14:22 -0800
Message-ID: <CAEPRUYrPXf7QNzput0bz_UPfytRy1eYgyOJYnH5v2v4DCEKSNA@mail.gmail.com>
References: <1386271244-3927-1-git-send-email-tim.kryger@linaro.org>
 <1386271244-3927-6-git-send-email-tim.kryger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1386271244-3927-6-git-send-email-tim.kryger@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tim Kryger <tim.kryger@linaro.org>, Chris Ball <cjb@laptop.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Device Tree List <devicetree@vger.kernel.org>, Axel Lin <axel.lin@ingics.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, Linaro Patches List <patches@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Thomas Gleixner <tglx@linutronix.de>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Dec 5, 2013 at 11:20 AM, Tim Kryger <tim.kryger@linaro.org> wrote:
> Enable the external clock needed by the host controller during the
> probe and disable it during the remove.
>
> Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
> Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>

Reviewed-by: Christian Daudt <bcm@fixthebug.org>

Chris,
 Are you ok with me pulling this patch along with the rest of the
patchset into the bcm tree?

 Thanks,
   csd
