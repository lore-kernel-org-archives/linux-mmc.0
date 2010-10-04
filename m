From: Sven Neumann <s.neumann@raumfeld.com>
Subject: 2.6.35.6 fails to suspend (pxa2xx-mci.0)
Date: Mon, 04 Oct 2010 09:30:35 +0200
Message-ID: <1286177435.2140.5.camel@sven>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Daniel Mack <daniel@caiaq.de>
List-Id: linux-mmc@vger.kernel.org

Hi,

we are running an embedded system here based on the PXA300 platform.
Suspend/resume used to work well so far. However after upgrading the
kernel from 2.6.34.7 to 2.6.35.6, we get the following error when trying
to suspend the system:

# echo "mem" > "/sys/power/state"
[ 5647.295953] PM: Syncing filesystems ... done.
[ 5647.318792] Freezing user space processes ... (elapsed 0.01 seconds) done.
[ 5647.337048] Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
[ 5647.356915] Suspending console(s) (use no_console_suspend to debug)
[ 5647.366651] pm_op(): platform_pm_suspend+0x0/0x5c returns -38
[ 5647.366671] PM: Device pxa2xx-mci.0 failed to suspend: error -38
[ 5647.367082] PM: Some devices failed to suspend


Regards,
Sven


-- 
Sven Neumann
Head of Software Development

RAUMFELD GmbH | Reichenberger Str. 124 | 10999 Berlin | Germany
Tel: +49.30.340.60.98.0 | Fax: +49.30.340.60.98.99 | s.neumann@raumfeld.com
